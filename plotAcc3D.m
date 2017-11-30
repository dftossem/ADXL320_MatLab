%% ALWAYS REMEMBER CLOSING SERIAL OBJECT AFTER FINISH
% Command to close serial connection:
% fclose(s)

% Creating serial object - Update with your COMX port
s = serial('COM3'); %assigns the object s to serial port
set(s, 'InputBufferSize', 1024); %number of bytes in input buffer
set(s, 'FlowControl', 'hardware');
set(s, 'BaudRate', 9600);
set(s, 'Parity', 'none');
set(s, 'DataBits', 8);
set(s, 'StopBit', 1);
set(s, 'Timeout',10);
set(s, 'Terminator',';');
fopen(s); %opens the serial port
R = 0;
P = 0;
% Square parallel to ground
x = [-0.5 -0.5 0.5 0.5];
y = [-0.5 0.5 0.5 -0.5];
z = [0 0 0 0];
c = [-0.5 -0.5 0.5 0.5];
% Plot plane
p = patch (x, y, z, c);
% Three axis limits
xlim([-1 1])
ylim([-1 1])
zlim([-1 1])
grid on
% Axis labels
xlabel('X')
ylabel('Y')
zlabel('Z')
% Pause while configuring 3D plot (continue pressing any key*) *Enter only
% tried
pause
% Loop (cancel with 'Ctrl+C')
while 1
    data = fgetl(s);
    C = strsplit(data,',');
    % Pitch in g
    P = str2double(cell2mat(C(1)));  % CAMBIAR POR R CUANDO SE ACTUALICE ARDUINO
    % Roll in g
    R = str2double(cell2mat(C(2)));
    % Pitch angular components in degrees
    aP = cosd(asind(P));
    bP = sind(asind(P));
    % Roll angular components in degrees
    aR = cosd(asind(R));
    bR = sind(asind(R));
    x = [-0.5*aP -0.5*aP 0.5*aP 0.5*aP];        % PITCH ALONE WORKING
%     z = [0.5*bP 0.5*bP -0.5*bP -0.5*bP];      % PITCH ALONE WORKING
    z = [0.5*bP-0.5*bR 0.5*bP+0.5*bR -0.5*bP+0.5*bR -0.5*bP-0.5*bR];    % PITCH & ROLL WORKING
    y = [-0.5*aR 0.5*aR 0.5*aR -0.5*aR];        % ROLL ALONE WORKING
%     z = [-0.5*b 0.5*b 0.5*b -0.5*b];          % ROLL ALONE WORKING
    % Clear plot
    delete(p)
    % Refresh plot
    p = patch(x, y, z, c)
    % Pause for matlab rest
    pause(0.01);
end