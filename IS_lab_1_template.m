% sprendime reikalaujama
% 1. duomenu paruosimas - matlabe arba data.txt. Atskirti mokymo ir
% testavimo duomenis.
% duomenys - pozymiai ir teisingi atsakymai.
% 2. paimti pradinius parametrus w1, w2, b.
% 3. tinklo atsako skaiciavimas kiekvienam mokymo pavyzdziui
% v = x1w1 + x2w2 + b1; y = 1 kai v > 0 ir y = -1 kai v < 0
% 4. skaiciuojame klaida e = T-y (y imame kiekvienam pvz atskirai)
% 5. Atnaujinam w1, w2, b (tinklo parametrus) kiekvienai klaidai.
% 6. Su naujausiomis w1, w2, b reiksmemis skaiciuojame y visiems mokymo
% pavyzdziams.
% 7. Skaiciuojame klaida e;
% 8. Jei bent vienam pavyzdziui klaida != 0 -> kartojame nuo 3 zingsnio
% 9. Tikriname (skaiciuojame atsaka y) testavimo duomenims.

%Classification using perceptron
[x1,x2] = gettrainingdata();
% estimated features are stored in matrix P:
P=[x1;x2];

%Desired output vector
T=[1;1;1;-1;-1;1;1]; % <- ČIA ANKSČIAU BUVO KLAIDA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

%% train single perceptron with two inputs and one output

% generate random initial values of w1, w2 and b
w1 = randn(1);
w2 = randn(1);
b = randn(1);

% calculate weighted sum with randomly generated parameters
%v1 = <...>; % write your code here
v = x1 * w1 + x2 * w2 + b;
% calculate current output of the perceptron 
y = [];
for i = 1:length(v)
       if v(i) > 0
            y=[y,1];
       else
            y=[y,-1];
       end
end
% calculate the error
e = T - y';

% calculate the total error for these 5 inputs 
E = abs(sum(e));

% write training algorithm
step_size = 0.1;
while E ~= 0 % executes while the total error is not 0
    for i = 1:length(v)
%       update parameters using current inputs ant current error
        w1 = w1 + step_size * e(i) * x1(i);
        w2 = w2 + step_size * e(i) * x2(i);
        b = b + step_size * e(i);
    end
    

    v = x1 * w1 + x2 * w2 + b;
    % calculate current output of the perceptron
    y = [];
    for i = 1:length(v)
           if v(i) > 0
                y=[y,1];
           else
                y=[y,-1];
           end
    end
    
    % % calculate the error
    e = T - y';
    
    E = sum(abs(e));
end

% Validation
[x1_validation,x2_validation] = gettestdata();
% estimated features are stored in matrix P:
% P_validation=[x1_validation;x2_validation];

v_validation = x1_validation * w1 + x2_validation * w2 + b;
y_validation = [];
T_validation = [1;1;1;-1;-1];
for i = 1:length(v_validation)
       if v_validation(i) > 0
            y_validation=[y_validation,1];
       else
            y_validation=[y_validation,-1];
       end
end
% calculate the error
e_validation = T_validation - y_validation';
% 
% calculate the total error for these 5 inputs 
E_validation = sum(abs(e_validation));

function [x1,x2] = gettrainingdata()
    %Reading apple images
    A4=imread('apple_07.jpg');
    A5=imread('apple_11.jpg');
    A6=imread('apple_12.jpg');
    A7=imread('apple_13.jpg');
    A8=imread('apple_17.jpg');
    A9=imread('apple_19.jpg');

    %Reading pears images
    P3=imread('pear_03.jpg');
    P4=imread('pear_09.jpg');

    %Calculate for each image, colour and roundness
    %For Apples
    %4th apple image(A4)
    hsv_value_A4=spalva_color(A4); %color
    metric_A4=apvalumas_roundness(A4); %roundness
    %5th apple image(A5)
    hsv_value_A5=spalva_color(A5); %color
    metric_A5=apvalumas_roundness(A5); %roundness
    %6th apple image(A6)
    hsv_value_A6=spalva_color(A6); %color
    metric_A6=apvalumas_roundness(A6); %roundness
    %7th apple image(A7)
    hsv_value_A7=spalva_color(A7); %color
    metric_A7=apvalumas_roundness(A7); %roundness
    %8th apple image(A8)
    hsv_value_A8=spalva_color(A8); %color
    metric_A8=apvalumas_roundness(A8); %roundness
    %9th apple image(A9)
    hsv_value_A9=spalva_color(A9); %color
    metric_A9=apvalumas_roundness(A9); %roundness

    %For Pears
    %3rd pear image(P3)
    hsv_value_P3=spalva_color(P3); %color
    metric_P3=apvalumas_roundness(P3); %roundness
    %2nd pear image(P4)
    hsv_value_P4=spalva_color(P4); %color
    metric_P4=apvalumas_roundness(P4); %roundness

    %selecting features(color, roundness, 3 apples and 2 pears)
    %A1,A2,A3,P1,P2
    %building matrix 2x5
    % data is put here -> change it to something else if you want to
    x1=[hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_P3 hsv_value_P4 hsv_value_A7 hsv_value_A8];
    x2=[metric_A4 metric_A5 metric_A6 metric_P3 metric_P4 metric_A7 metric_A8];
    
end

function [x1_validation,x2_validation] = gettestdata()
    %Reading apple images
    A1=imread('apple_04.jpg');
    A2=imread('apple_05.jpg');
    A3=imread('apple_06.jpg');

    %Reading pears images
    P1=imread('pear_01.jpg');
    P2=imread('pear_02.jpg');

    %Calculate for each image, colour and roundness
    %For Apples
    %1st apple image(A1)
    hsv_value_A1=spalva_color(A1); %color
    metric_A1=apvalumas_roundness(A1); %roundness
    %2nd apple image(A2)
    hsv_value_A2=spalva_color(A2); %color
    metric_A2=apvalumas_roundness(A2); %roundness
    %3rd apple image(A3)
    hsv_value_A3=spalva_color(A3); %color
    metric_A3=apvalumas_roundness(A3); %roundness

    %For Pears
    %1st pear image(P1)
    hsv_value_P1=spalva_color(P1); %color
    metric_P1=apvalumas_roundness(P1); %roundness
    %2nd pear image(P2)
    hsv_value_P2=spalva_color(P2); %color
    metric_P2=apvalumas_roundness(P2); %roundness

    %selecting features(color, roundness, 3 apples and 2 pears)
    %A1,A2,A3,P1,P2
    %building matrix 2x5
    % data is put here -> change it to something else if you want to
    x1_validation=[hsv_value_A1 hsv_value_A2 hsv_value_A3 hsv_value_P1 hsv_value_P2];
    x2_validation=[metric_A1 metric_A2 metric_A3 metric_P1 metric_P2];
    
end




