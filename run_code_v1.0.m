%To connect with CoppeliaSims using remoteApi
%
%Run the robot in CoppeliaSims

%First point is (0,0)
point1x=0;
point1y=0;

%User define the next point where the robot goes in the direction of vector
%(0,1)
point2x=0.25;  %Change the value here!
point2y=0.25;  %Change the value here!

syms a b r t1 t2
eqns = [a + r*cos(t1) == point1x, 
    b + r*sin(t1) == point1y,
    a + r*cos(t2) == point2x,
    b + r*sin(t2) == point2y,
    -r*sin(t1) == 0
    ];

S = solve(eqns,[a b r t1 t2]);

double(S.a(1,1))


%robot turn left or right
% r = negative value Vout < Vin
% r = positive value Vout > Vin

% Find Vin and Vout
radius = double(S.a(1,1));

if radius>0
    
    Vin = 0.3087641544056535 *(radius) - 0.046773596503533466;
    Vout = Vin + 0.1;
    
else
    
    Vout = 0.3087641544056535 *(radius) - 0.046773596503533466;
    Vin = Vout + 0.1;
    
end

%time 
t = 138.7368317867588 + 1.134372654229403* radius
% (difference between two angle t2-t1 divide by 2pi * t)

firstangle = double(S.t1(2,1))
secondangle = double(S.t2(2,1))

time = (abs(secondangle - firstangle) /(2 *pi)) * t


sim=remApi('remoteApi'); % using the prototype file (remoteApiProto.m)% using the prototype file (remoteApiProto.m)
%write anything here
sim.simxFinish(-1); % just in case, close all opened connections

clientID=sim.simxStart('127.0.0.1',19999,true,true,5000,5); %start the connection

if (clientID>-1)
        disp('Connected to remote API server');
        
        %define
        [number_returnCode,left_motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_leftMotor',sim.simx_opmode_blocking);
        [number_returnCode,right_motor]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_rightMotor',sim.simx_opmode_blocking);
        [number_returnCode,body]=sim.simxGetObjectHandle(clientID,'Pioneer_p3dx_visible',sim.simx_opmode_blocking);
        
        
       	[number_returnCode,eulerAngles]=sim.simxGetObjectOrientation(clientID,left_motor,-1,sim.simx_opmode_streaming);
         
           %position	
         [returnCode,middleneg1]=sim.simxGetObjectPosition(clientID,body,-1,sim.simx_opmode_streaming);
         %end of position taking
 
%          %move abit
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,left_motor,0.1,sim.simx_opmode_blocking);
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,right_motor,0.1,sim.simx_opmode_blocking);
          pause(0.1)

       tic
       s=20;
       for i=1:s
         %position	
         [returnCode,middle1(i,:)]=sim.simxGetObjectPosition(clientID,body,-1,sim.simx_opmode_streaming);
         %end of position taking
         
       
  [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,left_motor,Vout,sim.simx_opmode_blocking);
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,right_motor,Vin,sim.simx_opmode_blocking);
         pause(time/20)
       end 
       
             % stop
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,left_motor,0,sim.simx_opmode_blocking);
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,right_motor,0,sim.simx_opmode_blocking); 
         
         %position	
         [returnCode,middleend]=sim.simxGetObjectPosition(clientID,body,-1,sim.simx_opmode_streaming);
         %end of position taking
         toc
           end
           

 sim.delete(); % call the destructor!
 
 %List_line_plot

x1=[middle(1,1),middle(2,1),middle(3,1),middle(4,1),middle(5,1),middle(6,1),middle(7,1),middle(8,1),middle(9,1),middle(10,1),middle1(11,1),middle1(12,1),middle1(13,1),middle1(14,1),middle1(15,1),middle1(16,1),middle1(17,1),middle1(18,1),middle1(19,1),middle1(20,1),middleend(1)];
y1=[middle(1,2),middle(2,2),middle(3,2),middle(4,2),middle(5,2),middle(6,2),middle(7,2),middle(8,2),middle(9,2),middle(10,2),middle1(11,2),middle1(12,2),middle1(13,2),middle1(14,2),middle1(15,2),middle1(16,2),middle1(17,2),middle1(18,2),middle1(19,2),middle1(20,2),middleend(2)];
x=x1-middle(1,1);
y=y1-middle(1,2);
plot(x,y,'LineWidth',4);
hold on;
plot(x,y,'r*','MarkerSize',10);
hold on;
axis equal