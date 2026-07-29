# Lightweight health/telemetry heartbeat published by b2w_base_controller.
# Consumed by teleop, the future dashboard, and diagnostics.

std_msgs/Header header

uint8 sport_mode          # raw SportModeState.mode (3/5/6/7/14, 255=not yet received)
bool drivable             # true when sport_mode is 3 or 14 (Move commands are accepted)
bool deadman_ok           # true when a fresh /cmd_vel arrived within the timeout window
bool estopped             # true after a DAMP command, until a stand-up clears it

# The velocity the controller is currently streaming to the robot (post clamp/deadman).
float32 commanded_vx
float32 commanded_vy
float32 commanded_vyaw
