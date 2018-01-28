FROM tensorflow/tensorflow

RUN apt-get update
RUN apt-get install -y python-pip cython git wget curl vim libsm6 libxext6 libfontconfig1 libxrender1

RUN pip install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com opencv-python

ADD darkflow /darkflow
RUN cd /darkflow && pip install . && rm -rf /darkflow

ADD cfg cfg
ADD bin bin
ADD sample_img /img

ADD YOLO.ipynb /notebooks/YOLO.ipynb

CMD ["flow", "--imgdir", "/img", "--model", "cfg/yolo.cfg", "--load", "bin/yolo.weights", "--json"]
