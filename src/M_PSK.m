function [M_PSK_Opt ,PSK_Union_Band , M_PSK_Opt_With_SPS] = M_PSK( N ,M , Eb_N0_dB , Data )

Eb = 2 * 10.^(Eb_N0_dB/10) ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Numbers
Theory_S = pskmod( Data , M ,0 ,'gray' ) ; % Generating Constellation Diagram
Demad_Theory_S = pskdemod(Theory_S ,M ,0 ,'gray');
figure() ;
scatter(real(Theory_S),imag(Theory_S),'*b','linewidth',1);
hold on ;
grid on ;
title( "Constellation M = " + M + " (Eb/N0 = 3 dB)") ;
Symbol = zeros(1,M) ;
for k = 0 : M-1
    Symbol(k+1) = find( Data == k , 1 ) ;
    text( real(Theory_S(Symbol(k+1))) ,imag(Theory_S(Symbol(k+1)))+0.15 ,dec2base(Demad_Theory_S(Symbol(k+1)),2,4) );
    text( real(Theory_S(Symbol(k+1))) ,imag(Theory_S(Symbol(k+1)))-0.15 ,num2str(Demad_Theory_S(Symbol(k+1))) );
end

STD = std((Theory_S)) ;
Normalized_S =  Theory_S / STD  ; % Normilizing
Es = (log2(M) * Eb)' ;
Transmitted_S = sqrt(Es) * Normalized_S   ; % Generating Transmitted Signal
scatter(real(Transmitted_S(31,:)),imag(Transmitted_S(31,:)),'*r','linewidth',1) ;
yline(0) ;
xline(0) ;
legend("Theory" , "Transmitted") ;
%% Adding Channel Noise ( Gaussian Noise with Variance = 1 )
Noise = randn(1 , length(Transmitted_S)) + 1i * randn(1 , length(Transmitted_S)) ;
% Received Signal Affected By The Channel Noise
Received_Sig =  Transmitted_S + Noise ;
figure() ;
scatter( real(Received_Sig(31,:)) , imag(Received_Sig(31,:)) ,'filled', 'k' ) ;
title("Scatter Plot M =" + M + " (Eb/N0 = 3 dB)") ;
%% Demodulation & Decision Making
% Normalizing Received Signal
Normalized_Received_Sig = ( Received_Sig * STD ) ./ sqrt(Es) ;
% Calculating Decision Boundaries
boundries = zeros(1 , M/4) ;
for i = 1 : M/4
    boundries(i) = (pi/M) + (i-1)*(2*pi/M) ;
end
% Calculating Symbols Number In Gray Mapping
y = bin2gray( 0 : M-1 ,'psk' , M ) ;
Demod_Sig = zeros( size(Normalized_Received_Sig , 1) , size(Normalized_Received_Sig , 2) ) ;
% Decision Making
for row = 1 : size(Normalized_Received_Sig , 1)
    for column = 1 : size(Normalized_Received_Sig , 2)
        if sign( real(Normalized_Received_Sig(row , column)) ) >= 0 && ...
                sign( imag(Normalized_Received_Sig(row , column)) ) >= 0
            if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) < boundries(1)
                Demod_Sig(row,column) = y(1) ;
            elseif atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)) ) > boundries(end)
                Demod_Sig(row,column) = y((M/4) +1) ;
            end
            for k = 1 : (M/4) - 1
                if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) >= boundries(k) && ...
                        abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) <= boundries(k+1)
                    Demod_Sig(row,column) = y(k+1) ;
                    break ;
                end
                
            end
        elseif sign( real(Normalized_Received_Sig(row , column)) ) <= 0 && ...
                sign( imag(Normalized_Received_Sig(row , column)) ) >= 0
            if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) < boundries(1)
                Demod_Sig(row,column) = y((M/2)+1) ;
            elseif abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) > boundries(end)
                Demod_Sig(row,column) = y((M/4) +1) ;
            end
            for k = 1 : (M/4) - 1
                if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) >= boundries(k) && ...
                        abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) <= boundries(k+1)
                    Demod_Sig(row,column) = y((M/2)+ 1 - k) ;
                    break ;
                end
            end
            
        elseif sign( real(Normalized_Received_Sig(row , column)) ) <= 0 && ...
                sign( imag(Normalized_Received_Sig(row , column)) ) <= 0
            if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) > boundries(end)
                Demod_Sig(row,column) = y((3*M/4)+1) ;
            elseif abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) < boundries(1)
                Demod_Sig(row,column) = y((M/2)+1) ;
            end
            for k = 1 : (M/4) - 1
                if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) >= boundries(k) && ...
                        abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) <= boundries(k+1)
                    Demod_Sig(row,column) = y((M/2)+1 + k) ;
                    break ;
                end
            end
            
        elseif sign( real(Normalized_Received_Sig(row , column)) ) >= 0 && ...
                sign( imag(Normalized_Received_Sig(row , column)) ) <= 0
            if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) < boundries(1)
                Demod_Sig(row,column) = y(1) ;
            elseif abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) > boundries(end)
                Demod_Sig(row,column) = y((3*M/4)+1) ;
            end
            for k = 1 : (M/4) - 1
                if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) >= boundries(k) && ...
                        abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) <= boundries(k+1)
                    Demod_Sig(row,column) = y(M-k+1) ;
                    break ;
                end
            end
            
        end
        
    end
end
% Calculating Pe & BER
Pe = zeros(size(Received_Sig , 1) , 1 ) ;
for row = 1 : size(Demod_Sig , 1)
    for column = 1 : size(Demod_Sig , 2)
        if Demod_Sig(row , column) ~= Data(column)
            Pe(row) = Pe(row) + 1 ;
        end
    end
end
M_PSK_Opt = Pe' / Symbols_Num ;
% Calculating M_PSK Union Band ( It's a Tight One )
PSK_Union_Band = 2 * qfunc( sqrt( (sin(pi/M).^2)*2*Es / 2 ) ) ;

%% Transmitted Data With SPS = 10
SPS = 10 ;
Data_Sq = zeros( 1, Symbols_Num * SPS ) ;

for i = 1 : Symbols_Num % Generating Rectangular Pulse From Binary Inputs
    Data_Sq(((i-1)*SPS) + 1 : i*SPS  ) = Theory_S(i) ;
end

STD = std((Data_Sq)) ;
Normalized_S =  Data_Sq / STD  ; % Normilizing
Es = (log2(M) * Eb)' ;
Transmitted_S = sqrt(Es ./ SPS ) * Normalized_S   ; % Generating Transmitted Signal
%% Adding Channel Noise ( Gaussian Noise with Variance = 1 )
Noise = randn(1 , length(Transmitted_S)) + 1i * randn(1 , length(Transmitted_S)) ;
% Received Signal Affected By The Channel Noise
Received_Sig =  Transmitted_S + Noise ;
%% Demodulation & Decision Making
h = ones(1,SPS) ./ SPS ; % Moving Average Filter with Length = 10
y = zeros(size(Received_Sig,1) , size(Received_Sig,2) + SPS -1 ) ;
for counter = 1 : size(Received_Sig,1)
    y(counter,:) = conv(Received_Sig(counter,:) , h) ;
end
Temp = zeros(size(Received_Sig,1) , Symbols_Num) ;
for row = 1 : size(Received_Sig, 1)
    for column = 1 : Symbols_Num - 1
        Temp(row,column) = y(row , column*SPS ) ;
    end
end
% Normalizing Received Signal
Normalized_Received_Sig = ( Temp * STD ) ./ sqrt(Es./SPS) ;
% Calculating Decision Boundaries
boundries = zeros(1 , M/4) ;
for i = 1 : M/4
    boundries(i) = (pi/M) + (i-1)*(2*pi/M) ;
end
% Calculating Symbols Number In Gray Mapping
y = bin2gray( 0 : M-1 ,'psk' , M ) ;
Demod_Sig = zeros( size(Normalized_Received_Sig , 1) , size(Normalized_Received_Sig , 2) ) ;
% Decision Making
for row = 1 : size(Normalized_Received_Sig , 1)
    for column = 1 : size(Normalized_Received_Sig , 2)
        if sign( real(Normalized_Received_Sig(row , column)) ) >= 0 && ...
                sign( imag(Normalized_Received_Sig(row , column)) ) >= 0
            if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) < boundries(1)
                Demod_Sig(row,column) = y(1) ;
            elseif atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)) ) > boundries(end)
                Demod_Sig(row,column) = y((M/4) +1) ;
            end
            for k = 1 : (M/4) - 1
                if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) >= boundries(k) && ...
                        abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) <= boundries(k+1)
                    Demod_Sig(row,column) = y(k+1) ;
                    break ;
                end
                
            end
        elseif sign( real(Normalized_Received_Sig(row , column)) ) <= 0 && ...
                sign( imag(Normalized_Received_Sig(row , column)) ) >= 0
            if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) < boundries(1)
                Demod_Sig(row,column) = y((M/2)+1) ;
            elseif abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) > boundries(end)
                Demod_Sig(row,column) = y((M/4) +1) ;
            end
            for k = 1 : (M/4) - 1
                if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) >= boundries(k) && ...
                        abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) <= boundries(k+1)
                    Demod_Sig(row,column) = y((M/2)+ 1 - k) ;
                    break ;
                end
            end
            
        elseif sign( real(Normalized_Received_Sig(row , column)) ) <= 0 && ...
                sign( imag(Normalized_Received_Sig(row , column)) ) <= 0
            if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) > boundries(end)
                Demod_Sig(row,column) = y((3*M/4)+1) ;
            elseif abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) < boundries(1)
                Demod_Sig(row,column) = y((M/2)+1) ;
            end
            for k = 1 : (M/4) - 1
                if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) >= boundries(k) && ...
                        abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) <= boundries(k+1)
                    Demod_Sig(row,column) = y((M/2)+1 + k) ;
                    break ;
                end
            end
            
        elseif sign( real(Normalized_Received_Sig(row , column)) ) >= 0 && ...
                sign( imag(Normalized_Received_Sig(row , column)) ) <= 0
            if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) < boundries(1)
                Demod_Sig(row,column) = y(1) ;
            elseif abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                    real(Normalized_Received_Sig(row , column)))) > boundries(end)
                Demod_Sig(row,column) = y((3*M/4)+1) ;
            end
            for k = 1 : (M/4) - 1
                if abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) >= boundries(k) && ...
                        abs(atan(imag(Normalized_Received_Sig(row , column)) / ...
                        real(Normalized_Received_Sig(row , column)))) <= boundries(k+1)
                    Demod_Sig(row,column) = y(M-k+1) ;
                    break ;
                end
            end
            
        end
        
    end
end
% Calculating Pe & BER
Pe = zeros(size(Received_Sig , 1) , 1 ) ;
for row = 1 : size(Demod_Sig , 1)
    for column = 1 : size(Demod_Sig , 2)
        if Demod_Sig(row , column) ~= Data(column)
            Pe(row) = Pe(row) + 1 ;
        end
    end
end
M_PSK_Opt_With_SPS = Pe' / Symbols_Num ;

end