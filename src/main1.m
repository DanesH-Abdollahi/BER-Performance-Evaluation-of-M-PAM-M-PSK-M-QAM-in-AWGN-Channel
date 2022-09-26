% .........................................................................
% ****************  Communication II_Fall 2021_Dr.Emadi  ******************
% ***************************  HW-8 (M-PAM) *******************************
% ********************  DanesH Abdollahi - 9723053  ***********************
% .........................................................................
clc ; clear ; close all ;

%% Intitialization
N = 1e5 ; % Number Of Bits
Eb_N0_dB = 0 : 0.1 : 13 ;  

%% M_PAM
% B-PAM
M = 2 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Numbers 
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Two_PAM_Opt ,Two_PAM_Theory] = M_PAM( N ,M , Eb_N0_dB , Data ) ;
% 4_PAM
M = 4 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Four_PAM_Opt ,Four_PAM_Theory ] = M_PAM( N ,M , Eb_N0_dB , Data ) ;
% 8_PAM
M = 8 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Eight_PAM_Opt ,Eight_PAM_Theory ] = M_PAM( N ,M , Eb_N0_dB , Data ) ;
% 16_PAM
M = 16 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Sixteen_PAM_Opt ,Sixteen_PAM_Theory ] = M_PAM( N ,M , Eb_N0_dB , Data ) ;
% Plotting
figure() ;
% B-PAM
semilogy(Eb_N0_dB ,Two_PAM_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Two_PAM_Theory , '-.k','linewidth' , 1  ) ;
hold on ;
% 4-PAM
semilogy(Eb_N0_dB ,Four_PAM_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Four_PAM_Theory , '-.k','linewidth' , 1  ) ;
hold on ;
% 8-PAM
semilogy(Eb_N0_dB ,Eight_PAM_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Eight_PAM_Theory , '-.k','linewidth' , 1  ) ;
hold on ;
% 16-PAM
semilogy(Eb_N0_dB ,Sixteen_PAM_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Sixteen_PAM_Theory , '-.k','linewidth' , 1  ) ;
xlabel("Eb/N0 (dB)") ;
ylabel("Pe") ;
title("Bit Error Rate (BER)") ;
grid minor ;
legend( "M-PAM","Tehory",'Location','Southwest') ;
% Draw The Text-Arrow
annotation ( 'textarrow', [0.5 0.7], [0.4 .93] ,'String','M = 2 , 4 , 8 , 16' )
