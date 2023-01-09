#-------------------------------------------------------------------------
# Copyright(C) 2021 Intel Corporation.
# SPDX-License-Identifier: MIT
#--------------------------------------------------------------------------
# Build stage
ARG OPENVINO_VERSION="2022.1.0"
FROM openvino/onnxruntime_ep_ubuntu18:${OPENVINO_VERSION}
USER root

ENV WORKDIR_PATH=/home/openvino
WORKDIR $WORKDIR_PATH
ENV DEBIAN_FRONTEND noninteractive
ARG DEVICE=CPU_FP32
ARG OPENVINO_VERSION

ENV InferenceEngine_DIR=${INTEL_OPENVINO_DIR}/runtime/cmake

#Setup opencv
RUN apt update && apt -y install python-opencv && \
    cd /opt/intel/openvino_2022/extras/scripts && \
    ./download_opencv.sh
   
# use your custom path
ADD ../yolov5  /yolov5
ADD ./data /yolov5/data

RUN chmod 0777 /yolov5
RUN chgrp -R 0 /yolov5 && \
    chmod -R g=u /yolov5

RUN chmod 777 /yolov5/*

RUN echo "Intel devcloud Sample containerization begin ......."

ENV OPENVINO_VERSION=$OPENVINO_VERSION

ARG DEVICE="CPU_FP32"
ENV DEVICE=$DEVICE
#use your picture
ARG INPUT_FILE="000000000312.jpg"
ENV INPUT_FILE="$INPUT_FILE"
#use your model 
ARG MODEL="yolov5.xml"
ENV MODEL=$MODEL

RUN echo "Executing object detection sample using Intel Openvino Integration with ONNXRT  ......."

WORKDIR /yolov5

ENTRYPOINT /bin/bash -c "source yolov5.sh"
