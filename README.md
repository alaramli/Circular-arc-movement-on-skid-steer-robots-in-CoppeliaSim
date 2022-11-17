# circulararc4coppelia
A matlab code for circular arc movement on skid steer robots in CoppeliaSim

**README:**

**Starting file:** run\_code\_v1.1.m (Matlab file)

**Coding objective:** Robot movement in circular arc based on defined point

**INPUT:** The next point *(pointx2, pointy2)*

**OUTPUT:** Robot simulation in CoppeliaSim, data points from the simulation, List line plot graph obtained from the data points.

\*\* Note that the robot is located at the start point (0,0) and is facing towards point (0,1). 

\*\* Users have to define the next point as shown in the coding below

![](Aspose.Words.e249d387-eb44-45c2-910e-600fc7872c67.001.png)

\*\* Make sure before run the coding, you have the following files in the same folder to connect to the CoppeliaSim from Matlab:

1. remApi
1. remoteApi.dll
1. simpleTest
1. remoteApi.dylib
1. simpleSynchronousTest
1. remoteApiProto

Steps to run the coding

1. Change the value of point2x and point2y as shown above in “run\_code\_v1.1”
1. Open the CoppeliaSim scene named “CoppeliaSims\_Scene\_File”. Run the scene.
1. Run the Matlab coding which is “run\_code\_v1.1”.
1. Robot will move according to the velocity (Vin and Vout) and time obtained. This information is explained in our paper.

![](Aspose.Words.e249d387-eb44-45c2-910e-600fc7872c67.002.png)

5. The simulation point (x,y) will be store in  “middle1 “ as below

![](Aspose.Words.e249d387-eb44-45c2-910e-600fc7872c67.003.png)

6. The simulation plot will be plotted as 

    x = middle1(i,1)

    y = middle1(i,2)

    where i =1,2,3,…, 20

![](Aspose.Words.e249d387-eb44-45c2-910e-600fc7872c67.004.png)


