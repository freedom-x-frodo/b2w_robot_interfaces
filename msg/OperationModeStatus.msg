# What state the robot is in and what the mode manager is doing about it.
# Published continuously by b2w_control's robot_mode_manager, so clients
# (teleop, a future mission BT, diagnostics) can gate on readiness instead of
# guessing from raw sport modes.

std_msgs/Header header

uint8 NONE=255            # also the "unknown" value for `current`

# Operation modes -- values are SetOperationMode's constants (that srv is the
# single source of truth). NONE when the observed sport mode maps to no
# operation mode (e.g. damped after a fall).
uint8 current
uint8 target              # NONE when idle: no goal is being pursued
bool transitioning        # true iff target != NONE

# Hardware truth, straight from SportModeState via BaseControllerStatus.
bool drivable             # the robot will act on Move right now (sport mode 3 or 14)
uint8 sport_mode          # raw mode: 3, 5, 6, 7, 14; 255 = not yet observed

uint8 GAIT_CRUISE=0       # sport mode 14, gait 0
uint8 GAIT_AGILE=1        # sport mode 3, gait 1
uint8 GAIT_NONE=255       # not in a gait (lying, lock-standing, damped, unknown)
uint8 active_gait

# Empty while healthy. Set when a goal is rejected or a transition fails, and
# kept until the next goal so a failure is not lost between status messages.
string last_error
