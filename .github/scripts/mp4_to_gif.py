import imageio.v3 as iio
import numpy as np

input_path = ".github/assets/header_video.mp4"
output_path = ".github/assets/header.gif"

print("Reading video...")
frames = iio.imread(input_path, plugin="pyav")
print(f"Total frames: {len(frames)}, shape: {frames[0].shape}")

# Take every 3rd frame to reduce size, cap at 80 frames
step = max(1, len(frames) // 80)
selected = frames[::step]
print(f"Selected {len(selected)} frames (every {step}th)")

# Resize to 720px wide to keep GIF manageable
from PIL import Image
resized = []
for f in selected:
    img = Image.fromarray(f)
    w, h = img.size
    new_w = 720
    new_h = int(h * new_w / w)
    img = img.resize((new_w, new_h), Image.LANCZOS)
    resized.append(np.array(img))

print(f"Writing GIF at {new_w}x{new_h}...")
iio.imwrite(output_path, resized, duration=80, loop=0)

import os
size_mb = os.path.getsize(output_path) / (1024*1024)
print(f"Done! GIF size: {size_mb:.1f} MB")
