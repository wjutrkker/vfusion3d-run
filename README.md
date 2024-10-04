git clone  https://github.com/facebookresearch/vfusion3d

docker build -t vfusion3d:latest . 
docker run --gpus 1 -it -v $PWD:/code --network host vfusion3d:latest bash

conda activate vfus
python3 /code/gradio_app.py --listen
