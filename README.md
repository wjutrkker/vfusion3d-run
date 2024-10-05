# Running Vfusion3D 

First thing you'll do is pull the vfusion3d code base. Build the docker container and run the Gradio image. 
```
git clone  https://github.com/facebookresearch/vfusion3d

docker build -t vfusion3d:latest . 
docker run  

docker run --gpus 1 -it -v $PWD:/code --network host vfusion3d:latest bash

conda activate vfus
python3 /code/gradio_app.py --listen
```

or 