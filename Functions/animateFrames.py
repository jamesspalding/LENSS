# SPDX-FileCopyrightText: 2024 GLAS Education <angel@glaseducation.org>
# SPDX-License-Identifier: AGPL-3.0-only

import os
import shutil
from PIL import Image

def animateFrames(directory, output_file="animated_plot.gif", duration=200):
    images = []
    for filename in sorted(os.listdir(directory)):
        if filename.endswith('.png'):
            img_path = os.path.join(directory, filename)
            images.append(Image.open(img_path))

    images[0].save(
        output_file,
        save_all=True,
        append_images=images[1:],
        duration=duration,
        loop=0)

    #remove tempframes
    shutil.rmtree(directory)
