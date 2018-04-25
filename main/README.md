# Main script

Useing a iteration algrithem to calculate the thrushold to binarization the image. The use the matlab build-in function `regionprops` to get the object information.

## The iteration based image thrashold

1. Choose a initial T.

1. Thrushold T seperate the image into two part R_1 R_2.

1. Calculate the average greylevel of R_1 and R_2 region u_1 and u_2.

1. Iterate the thrushold T, T = (u_1 + u_2) / 2

1. Recalculate 2~4 until T does not change much.

## Innovation point

1. The initial thrushold of the next frame is the final thrushold of the last frame.

1. The thrushold of the next frame is calculated near the center of the last frame.

These two point not only save the computing power but also somewhat compensate the effect of cloud.