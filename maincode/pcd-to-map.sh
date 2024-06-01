#!/bin/bash

# 进入 ROS 工作空间
cd ~/pcd2pgm_ws

# 设置Bag包保存路径
path="./Bag/map"

# 构建 ROS 软件包
catkin_make

# 启动 ROS 主节点
gnome-terminal -- roscore

# 在另一个终端中运行 pcd2topic 节点
gnome-terminal --
  source devel/setup.bash
  rosrun pcd2pgm pcd2topic &

# 在另一个终端中运行 map_saver 节点
gnome-terminal -- bash -c "
  cd ..;
  cd '$path';
  source devel/setup.bash;
  rosrun map_server map_saver
  exec bash"
xdotool windowactivate --sync $(xdotool getactivewindow)
# 等待所有进程结束  
wait
