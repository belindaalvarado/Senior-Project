# Prediction interface for Cog ⚙️
# https://github.com/replicate/cog/blob/main/docs/python.md

from cog import BasePredictor, Input, Path
import shutil
import tempfile

import argparse

import torch
import torchvision
import numpy as np
import sys
import os
import dlib

from PIL import Image

from models.Embedding import Embedding
from models.Alignment import Alignment
from models.Blending import Blending

from utils.drive import open_url
from utils.shape_predictor import align_face
import PIL


class Predictor(BasePredictor):
    def setup(self) -> None:
        """Load the model into memory to make running multiple predictions efficient"""
        # self.model = torch.load("./weights.pth")
        self.args = get_args()
        # self.args.save_dir = "temp_outdir"
        # self.args.output_dir = self.args.save_dir

    def predict(
        self,
        source_image: Path = Input(description="Face"),
        target_image: Path = Input(description="Hair Shape"),
        color_image: Path =  Input(description="Hair Color")
    ) -> Path:
        """Run a single prediction on the model"""
        print(source_image, target_image, color_image)
        DIR = os.getcwd()
        UNPROCESSED_DIR = DIR + "/unprocessed"
        print("DIR:", DIR)
        CHILD = os.listdir(DIR)
        print("CHILD_DIR:", CHILD)
        
        print("img", DIR + "/" + self.args.input_dir + "/" + self.args.im_path1)

        im_path1, im_path2, im_path3 = str(source_image), str(target_image), str(color_image)

        im_name_1 = Path(im_path1).parts[-1]
        im_name_2 = Path(im_path2).parts[-1]
        im_name_3 = Path(im_path3).parts[-1]
        print("image names", im_name_1, im_name_2, im_name_3)

        # img1 = Image.open(DIR + "/" + self.args.input_dir + "/" + self.args.im_path1)
        print("PATH",im_path1, " ", UNPROCESSED_DIR + "/" + im_name_1)
        img1 = Image.open(im_path1)
        img1.save(UNPROCESSED_DIR + "/" + im_name_1)
        img1.close()

        img2 = Image.open(im_path2)
        img2.save(UNPROCESSED_DIR + "/" + im_name_2)
        img2.close()

        img3 = Image.open(im_path3)
        img3.save(UNPROCESSED_DIR + "/" + im_name_3)
        img3.close()

        cache_dir = Path(self.args.cache_dir)
        cache_dir.mkdir(parents=True, exist_ok=True)

        processed_output_dir = Path(self.args.processed_output_dir)
        processed_output_dir.mkdir(parents=True,exist_ok=True)
        print("processed output dir:", processed_output_dir)

        print("Downloading Shape Predictor")
        f=open_url("https://drive.google.com/uc?id=1huhv8PYpNNKbGCLOaYUjOgR1pY5pmbJx", cache_dir=cache_dir, return_path=True)
        predictor = dlib.shape_predictor(f)

        for im in Path(self.args.unprocessed_dir).glob("*.*"):
            faces = align_face(str(im),predictor)

            for i,face in enumerate(faces):
                if(self.args.output_size):
                    factor = 1024//self.args.output_size
                    assert self.args.output_size*factor == 1024
                    face_tensor = torchvision.transforms.ToTensor()(face).unsqueeze(0).cuda()
                    face_tensor_lr = face_tensor[0].cpu().detach().clamp(0, 1)
                    face = torchvision.transforms.ToPILImage()(face_tensor_lr)
                    if factor != 1:
                        face = face.resize((self.args.output_size, self.args.output_size), PIL.Image.LANCZOS)
                if len(faces) > 1:
                    face.save(Path(self.args.processed_output_dir) / (im.stem+f"_{i}.png"))
                    print("More than one Face")
                else:
                    # output_path = Path(self.args.processed_output_dir) / (im.stem + f".png")
                    face.save(Path(self.args.processed_output_dir) / (im.stem + f".png"))


        print("im_path1:", im_path1)

        im_name_1 = os.path.splitext(os.path.basename(im_path1))[0]
        im_name_2 = os.path.splitext(os.path.basename(im_path2))[0]
        im_name_3 = os.path.splitext(os.path.basename(im_path3))[0]

        im_path1 = DIR + "/" + self.args.input_dir + "/" + im_name_1 + ".png"
        im_path2 = DIR + "/" + self.args.input_dir + "/" + im_name_2 + ".png"
        im_path3 = DIR + "/" + self.args.input_dir + "/" + im_name_3 + ".png"

        # Step 1 : Embedding source and target images into W+, FS space
        ii2s = Embedding(self.args)

        im_set = {im_path1, im_path2, im_path3}
        ii2s.invert_images_in_W([*im_set])
        ii2s.invert_images_in_FS([*im_set])

        # Step 2 : Hairstyle transfer using the above embedded vector or tensor
        align = Alignment(self.args)
        align.align_images(im_path1, im_path2, sign=self.args.sign, align_more_region=False, smooth=self.args.smooth)
        if im_path2 != im_path3:
            align.align_images(im_path1, im_path3, sign=self.args.sign, align_more_region=False, smooth=self.args.smooth, save_intermediate=False)

        blend = Blending(self.args)
        blend.blend_images(im_path1, im_path2, im_path3, sign=self.args.sign)

        out_image = Image.open(f"{self.args.output_dir}/{im_name_1}_{im_name_2}_{im_name_3}_realistic.png")
        out_path = Path(tempfile.mkdtemp()) / "output.png"
        out_image.save(str(out_path))
        out_image.save(str("oo.png"))

        return out_path

def get_args():

    parser = argparse.ArgumentParser(description='Barbershop')

    # I/O arguments
    parser.add_argument('--input_dir', type=str, default='input/face',
                        help='The directory of the images to be inverted')
    parser.add_argument('--output_dir', type=str, default='output',
                        help='The directory to save the latent codes and inversion images')
    parser.add_argument('--im_path1', type=str, default='16.png', help='Identity image')
    parser.add_argument('--im_path2', type=str, default='15.png', help='Structure image')
    parser.add_argument('--im_path3', type=str, default='117.png', help='Appearance image')
    parser.add_argument('--sign', type=str, default='realistic', help='realistic or fidelity results')
    parser.add_argument('--smooth', type=int, default=5, help='dilation and erosion parameter')
    #new additions
    parser.add_argument("--embedding_dir",type=str,default="./output/",help="embedding vector directory",)

    # StyleGAN2 setting
    parser.add_argument('--size', type=int, default=1024)
    parser.add_argument('--ckpt', type=str, default="pretrained_models/ffhq.pt")
    parser.add_argument('--channel_multiplier', type=int, default=2)
    parser.add_argument('--latent', type=int, default=512)
    parser.add_argument('--n_mlp', type=int, default=8)

    # Arguments
    parser.add_argument('--device', type=str, default='cuda')
    parser.add_argument('--seed', type=int, default=None)
    parser.add_argument('--tile_latent', action='store_true', help='Whether to forcibly tile the same latent N times')
    parser.add_argument('--opt_name', type=str, default='adam', help='Optimizer to use in projected gradient descent')
    parser.add_argument('--learning_rate', type=float, default=0.01, help='Learning rate to use during optimization')
    parser.add_argument('--lr_schedule', type=str, default='fixed', help='fixed, linear1cycledrop, linear1cycle')
    parser.add_argument('--save_intermediate', action='store_true',
                        help='Whether to store and save intermediate HR and LR images during optimization')
    parser.add_argument('--save_interval', type=int, default=300, help='Latent checkpoint interval')
    parser.add_argument('--verbose', action='store_true', help='Print loss information')
    parser.add_argument('--seg_ckpt', type=str, default='pretrained_models/seg.pth')

    # Embedding loss options
    parser.add_argument('--percept_lambda', type=float, default=1.0, help='Perceptual loss multiplier factor')
    parser.add_argument('--l2_lambda', type=float, default=1.0, help='L2 loss multiplier factor')
    parser.add_argument('--p_norm_lambda', type=float, default=0.001, help='P-norm Regularizer multiplier factor')
    parser.add_argument('--l_F_lambda', type=float, default=0.1, help='L_F loss multiplier factor')
    parser.add_argument('--W_steps', type=int, default=1100, help='Number of W space optimization steps')
    parser.add_argument('--FS_steps', type=int, default=250, help='Number of W space optimization steps')

    # Alignment loss options
    parser.add_argument('--ce_lambda', type=float, default=1.0, help='cross entropy loss multiplier factor')
    parser.add_argument('--style_lambda', type=str, default=4e4, help='style loss multiplier factor')
    parser.add_argument('--align_steps1', type=int, default=140, help='')
    parser.add_argument('--align_steps2', type=int, default=100, help='')

    # Blend loss options
    parser.add_argument('--face_lambda', type=float, default=1.0, help='')
    parser.add_argument('--hair_lambda', type=str, default=1.0, help='')
    parser.add_argument('--blend_steps', type=int, default=400, help='')

    #alignment options
    parser.add_argument('-unprocessed_dir', type=str, default='unprocessed', help='directory with unprocessed images')
    parser.add_argument('-processed_output_dir', type=str, default='input/face', help='output directory')

    parser.add_argument('-output_size', type=int, default=1024, help='size to downscale the input images to, must be power of 2')
    parser.add_argument('-processing_seed', type=int, help='manual seed to use')
    parser.add_argument('-cache_dir', type=str, default='cache', help='cache directory for model weights')

    ###############
    parser.add_argument('-inter_method', type=str, default='bicubic')
    return parser.parse_args([]) 

    # args = parser.parse_args([])    

    # return args 

def get_im_paths_not_embedded(args, im_paths):
    W_embedding_dir = os.path.join(args.embedding_dir, "W+")
    FS_embedding_dir = os.path.join(args.embedding_dir, "FS")

    im_paths_not_embedded = []
    for im_path in im_paths:
        assert os.path.isfile(im_path)

        im_name = os.path.splitext(os.path.basename(im_path))[0]
        W_exists = os.path.isfile(os.path.join(W_embedding_dir, f"{im_name}.npy"))
        FS_exists = os.path.isfile(os.path.join(FS_embedding_dir, f"{im_name}.npz"))

        if not (W_exists and FS_exists):
            im_paths_not_embedded.append(im_path)

    return im_paths_not_embedded
