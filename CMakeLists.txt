cmake_minimum_required(VERSION 3.8)
project(b2w_robot_interfaces)

find_package(ament_cmake REQUIRED)
find_package(rosidl_default_generators REQUIRED)
find_package(std_msgs REQUIRED)
# BoundingBox3D embeds geometry_msgs/Pose and Vector3.
find_package(geometry_msgs REQUIRED)

rosidl_generate_interfaces(${PROJECT_NAME}
  "msg/BaseControllerStatus.msg"
  "msg/OperationModeStatus.msg"
  "msg/BoundingBox3D.msg"
  "msg/BoundingBox3DArray.msg"
  "srv/SetRobotMode.srv"
  "srv/SetOperationMode.srv"
  "srv/SelectCamera.srv"
  DEPENDENCIES std_msgs geometry_msgs
)

ament_export_dependencies(rosidl_default_runtime)

ament_package()
