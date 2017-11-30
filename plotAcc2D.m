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
% set(s, 'Terminator',';');
fopen(s); %opens the serial port
grid on
% Axis labels
xlabel('Time [s]')
ylabel('Gravity [m/s^2]')
hold on
pause
% Loop (cancel with 'Ctrl+C')
tic
i = 1;
time = [];
while 1
    data = fscanf(s);
    flushinput(s);
    C = strsplit(data,',');
    % Pitch in g
    P = str2double(cell2mat(C(1)));
    % Roll in g
    R = str2double(cell2mat(C(2)));
    t = toc;
    plot(t, R, '-*g')
    plot(t, P, '-*r')
    Pitch(i,:) = [t,P];
    Roll(i,:) = [t,R];
    drawnow;
    % Pause for matlab rest
    i = i + 1;
    pause(0.005);
end
% csvwrite(sFile,data);
