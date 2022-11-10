%
%
%To connect with CoppeliaSims using remoteApi
%
%
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
         
       
  [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,left_motor,0.1304174,sim.simx_opmode_blocking);
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,right_motor,0.0304174,sim.simx_opmode_blocking);
         pause(1.73776)
       end 
       
       s=20;
       for i=1:s
           
            %position	
         [returnCode,middle2(i,:)]=sim.simxGetObjectPosition(clientID,body,-1,sim.simx_opmode_streaming);
         %end of position taking
         
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,left_motor,0.246204,sim.simx_opmode_blocking);
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,right_motor,0.146204,sim.simx_opmode_blocking);
         pause(1.029)
         
       end 
%        
%       
       
%        
%          
%          
             % stop
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,left_motor,0,sim.simx_opmode_blocking);
         [number_returnCode]=sim.simxSetJointTargetVelocity(clientID,right_motor,0,sim.simx_opmode_blocking); 
         
         %position	
         [returnCode,middleend]=sim.simxGetObjectPosition(clientID,body,-1,sim.simx_opmode_streaming);
         %end of position taking
         toc
           end
           

 sim.delete(); % call the destructor!
 
 List_line_plot