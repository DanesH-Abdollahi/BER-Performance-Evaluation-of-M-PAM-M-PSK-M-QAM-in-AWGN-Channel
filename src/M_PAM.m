function [M_PAM_Opt ,M_PAM_Theory] = M_PAM( N ,M , Eb_N0_dB , Data )
Eb = 2 * 10.^(Eb_N0_dB/10) ; 
Symbols_Num = floor( N ./ log2(M) ) ;
Theory_S = pammod( Data ,M ,0 ,'gray') ; % Generating Constellation Diagram
Demad_Theory_S = pamdemod(Theory_S ,M ,0 ,'gray');
figure() ;
subplot(2,1,1) ;
scatter(real(Theory_S),zeros(1,length(Theory_S)),'*b','linewidth',1);
hold on ;
grid on ;
title( "Constellation M = " + M + " (Eb/N0 = 3 dB)") ;
Symbol = zeros(1,M) ;
for k = 0 : M-1
    Symbol(k+1) = find( Data == k , 1 ) ;
    text( real(Theory_S(Symbol(k+1))) ,imag(Theory_S(Symbol(k+1)))+0.4 ,dec2base(Demad_Theory_S(Symbol(k+1)),2,4) );
    text( real(Theory_S(Symbol(k+1))) ,imag(Theory_S(Symbol(k+1)))-0.4 ,num2str(Demad_Theory_S(Symbol(k+1))) );
end
STD = std(Theory_S) ;
Normalized_S =  Theory_S / STD  ; % Normilizing 
Es = (log2(M) * Eb)' ; 
Transmitted_S = sqrt(Es) * Normalized_S   ; % Generating Transmitted Signal
scatter(real(Transmitted_S(31,:)),zeros(1,length(Theory_S)),'*r','linewidth',1) ;
yline(0) ;
xline(0) ;
xlabel("In-Phase") ;
ylabel("Quadrature") ;
legend("Theory" , "Transmitted") ;

%% Adding Channel Noise ( Gaussian Noise with Variance = 1 ) 
Noise = randn(1 , length(Transmitted_S)) + 1i * randn(1 , length(Transmitted_S)) ;
% Received Signal Affected By The Channel Noise
Received_Sig =  Transmitted_S + Noise ; 
subplot(2,1,2) ;
scatter( real(Received_Sig(31,:)) , imag(Received_Sig(31,:)) ,'filled', 'k' ) ;
title("Scatter Plot M =" + M + " (Eb/N0 = 3 dB)") ;
xlabel("In-Phase") ;
ylabel("Quadrature") ;

%% Demodulation & Decision Making
d_min =  2* sqrt(Es) / STD ; % Calculating Minumun Distance 
% Normalizing Received Signal
Normalized_Received_Sig = ( Received_Sig * STD ) ./ sqrt(Es) ; 
Boundries = zeros(1,M-1) ; % Calculating Decision Boundaries
for m = 1 : (M - 1)
   Boundries(m) =  M - 2*m ;
end
Boundries = flip( Boundries ) ;
% Calculating Symbols Number In Gray Mapping
y = bin2gray( 0 : M-1 ,'pam' , M ) ; 
Demod_Sig = zeros( size(Normalized_Received_Sig , 1) , size(Normalized_Received_Sig , 2) ) ;
% Decision Making
for row = 1 : size(Normalized_Received_Sig , 1)
    for column = 1 : size(Normalized_Received_Sig , 2)
        if real(Normalized_Received_Sig(row , column)) <= Boundries(1)
            Demod_Sig(row,column) = y(1) ;
        elseif real(Normalized_Received_Sig(row , column)) >= Boundries(end)
            Demod_Sig(row,column) = y(end) ;
        elseif 1
            for k = 1 : M-2
                if real(Normalized_Received_Sig(row , column)) >= Boundries(k) && ...
                        real(Normalized_Received_Sig(row , column)) <= Boundries(k+1)
                    Demod_Sig(row,column) = y(k+1) ;
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
M_PAM_Opt = Pe' / Symbols_Num ;
% Pe(Theory) = Qfunc( d_min / sqrt(2*N0) ) & N0 = 2 
M_PAM_Theory =(2*(M-1)/M) * qfunc( d_min / 2 ) ;
end