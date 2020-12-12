%   ECE6011 Introduction To Robotics
%   OWI Piano Playing Robot
%   Fall 2020
%
%   Team: Rafay Akhter, Arian Ehteshami, Andrew Han, Leslie Nix
%
%
function FinalProject()
%Setup 
clear a motor1 motor2 motor3 motor4 shield;

a = arduino('/dev/cu.usbmodem14101', 'Mega2560', 'Libraries','Adafruit/MotorShieldV2');
shield = addon(a, 'Adafruit/MotorShieldV2');

motor1 = dcmotor(shield,1,'Speed',-.4); %Speed range from -1 to 1
motor3 = dcmotor(shield,3,'Speed',-.7);

%Read Song from txt file
songRead = fopen('song.txt', 'r');
Notes = fscanf(songRead, '%c');
fclose(songRead);

current = 1;
next = 2;
press();
%Sequence of motions following array from Song file
for current = 1:length(Notes)-1
    next = current + 1;
    if(Notes(current) < Notes(next))
        Right();
    elseif (Notes(current) > Notes(next))
        Left();
    else 
        press();
    end

end

returnToC();

%FUNCTIONS
    function returnToC() %Returns to starting Position of C
        if(Notes(current) ==  'D')
            goToG();
            goToC();
        else
            goToC();
        end
    end 
    function Right() %Sequences of motions to the right
        if(Notes(current) == 'C' && Notes(next) == 'E')
            m1 = readVoltage(a,'A8');
            x = 0;
            motor1.Speed = -.4;
            while(m1 < 2.36)
                m1 = readVoltage(a,'A8');
                if(x == 0)
                    start(motor1);
                    x = x+1;
                end
            end
            stop(motor1);
            press();
        elseif(Notes(current) == 'C' && Notes(next) == 'F')
            m1 = readVoltage(a,'A8');
            x = 0;
            motor1.Speed = -.4;
            while(m1 < 2.42)
            m1 = readVoltage(a,'A8');
                if(x == 0)
                    start(motor1);
                    x = x+1;
                end
            end
            stop(motor1);
            press();
        elseif(Notes(current) == 'C' && Notes(next) == 'G')
            goToG();
            press();
        elseif(Notes(current) == 'D' && Notes(next) == 'F')
            m1 = readVoltage(a,'A8');
            x = 0;
            motor1.Speed = -.4;
            while(m1 < 2.42)
                m1 = readVoltage(a,'A8');
                if(x == 0)
                    start(motor1);
                    x = x+1;
                end
            end
            stop(motor1);
            press();
        elseif(Notes(current) == 'D' && Notes(next) == 'G')
            goToG();
            press();
        else
            goToG();
            press();
        end
    end
    function Left() %Sequences of motions to the left
        if(Notes(current) == 'G' && Notes(next) == 'E')
            m1 = readVoltage(a,'A8');
            motor1.Speed = .4;
            x = 0;
            while(m1 > 2.44)
                m1 = readVoltage(a,'A8');
                if(x == 0)
                start(motor1);
                x = x+1;
                end
            end
        stop(motor1);
        press();
        elseif(Notes(current) == 'G' && Notes(next) == 'D')
            m1 = readVoltage(a,'A8');
            x = 0;
            motor1.Speed = .4;
            while(m1 > 2.36)
                m1 = readVoltage(a,'A8');
                if(x == 0)
                    start(motor1);
                    x = x+1;
                end
            end
            stop(motor1);
            press();
        elseif(Notes(current) == 'G' && Notes(next) == 'C')
            goToC();
            press();
        elseif(Notes(current) == 'F' && Notes(next) == 'D')
            m1 = readVoltage(a,'A8');
            x = 0;
            motor1.Speed = .4;
            while(m1 > 2.36)
                m1 = readVoltage(a,'A8');
                if(x == 0)
                start(motor1);
                x = x+1;
                end
            end
            stop(motor1);
            press();
        elseif(Notes(current) == 'F' && Notes(next) == 'C')
            goToC();
            press();
        else
            goToC();
            press();
        end
    end
    function goToC() %Goes to C position
        m1 = readVoltage(a,'A8');
        x = 0;
        motor1.Speed = .4;
        while(m1 > 2.26)
            m1 = readVoltage(a,'A8');
            if(x == 0)
                start(motor1);
                x = x+1;
            end
        end
        stop(motor1);
    end
    function goToG() %Goes to G position
        m1 = readVoltage(a,'A8');
        x = 0;
        motor1.Speed = -.4;
        while(m1 < 2.52)
            m1 = readVoltage(a,'A8');
            if(x == 0)
                start(motor1);
                x = x+1;
            end
        end
        stop(motor1);
    end
    function press() %Presses the key down
        x = 0;
        motor3.Speed = -.6;
        m3 = readVoltage(a,'A10');
        while(m3 > .67) %set to < .75 to reset
            m3 = readVoltage(a,'A10');
            if(x == 0)
                start(motor3);
                x = x+1;
            end
        end
        pause(.3);%%%%%%%%%% ADD delay here
        stop(motor3);
        motor3.Speed = .6;

        x = 0;
        while(m3 < .75) %set to < .75 to reset
            m3 = readVoltage(a,'A10');
            if(x == 0)
                start(motor3);
                x = x+1;
            end
        end
        stop(motor3);
    end
end
