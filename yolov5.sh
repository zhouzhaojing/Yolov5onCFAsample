#!/usr/bin/env python3

echo "Openvino Package Version: openvino_$OPENVINO_VERSION"
echo "Device:  $DEVICE"
echo "MODEL:  $MODEL"
export INPUT_FILE="/yolov5/data/"$INPUT_FILE
echo "Input file $INPUT_FILE"

export MODEL="/yolov5/data/"$MODEL
source /opt/intel/openvino_2022/setupvars.sh

echo "Using Openvino Integration with ONNXRT"
#you can use this method to transmit parameter
#python3 yolov5.py -m $MODEL -i $INPUT_FILE -d $DEVICE 
python3 yolov5.py