% .........................................................................
% ****************  Communication II_Fall 2021_Dr.Emadi  ******************
% ******************************  HW-8  ***********************************
% ********************  DanesH Abdollahi - 9723053  ***********************
% .........................................................................
clc ; clear ; close all ;

%% Intitialization
N = 1e5 ; % Number Of Bits
Eb_N0_dB = 0 : 0.1 : 13 ;  

%% M_PSK
% 4-PSK
M = 4 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Four_PSK_Opt ,Four_PSK_Union_Band , Four_PSK_Opt_With_SPS] = M_PSK( N ,M , Eb_N0_dB , Data ) ;
% 8-PSK
M = 8 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Eight_PSK_Opt ,Eight_PSK_Union_Band , Eight_PSK_Opt_With_SPS] = M_PSK( N ,M , Eb_N0_dB , Data ) ;
% 16-PSK
M = 16 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Sixteen_PSK_Opt ,Sixteen_PSK_Union_Band , Sixteen_PSK_Opt_With_SPS] = M_PSK( N ,M , Eb_N0_dB , Data ) ;
% 32-PSK
M = 32 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Thirtytwo_PSK_Opt ,Thirtytwo_PSK_Union_Band , Thirtytwo_PSK_Opt_With_SPS] = M_PSK( N ,M , Eb_N0_dB , Data ) ;
% 64-PSK
M = 64 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Sixtyfour_PSK_Opt ,Sixtyfour_PSK_Union_Band , Sixtyfour_PSK_Opt_With_SPS] = M_PSK( N ,M , Eb_N0_dB , Data ) ;
% Plotting
figure() ;
% 4-PAM
semilogy(Eb_N0_dB ,Four_PSK_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Four_PSK_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Four_PSK_Opt_With_SPS , '-. b','linewidth' , 1  ) ;
hold on ;
% 8-PAM
semilogy(Eb_N0_dB ,Eight_PSK_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Eight_PSK_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Eight_PSK_Opt_With_SPS , '-. b','linewidth' , 1  ) ;
hold on ;
% 16-PAM
semilogy(Eb_N0_dB ,Sixteen_PSK_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Sixteen_PSK_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Sixteen_PSK_Opt_With_SPS , ' b','linewidth' , 1  ) ;
hold on ;
% 32-PAM
semilogy(Eb_N0_dB ,Thirtytwo_PSK_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Thirtytwo_PSK_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Thirtytwo_PSK_Opt_With_SPS , '-. b','linewidth' , 1  ) ;
hold on ;
% 64-PAM
semilogy(Eb_N0_dB ,Sixtyfour_PSK_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Sixtyfour_PSK_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Sixtyfour_PSK_Opt_With_SPS , '-. b','linewidth' , 1  ) ;
xlabel("Eb/N0 (dB)") ;
ylabel("Pe") ;
title("Bit Error Rate (BER)") ;
grid minor ;
legend( "M-PSK","M-PSK-Union-Band","M-PSK-With-SPS",'Location','Southwest') ;
annotation ( 'textarrow', [0.5 0.7], [0.4 .93] ,'String','M = 4 , 8 , 16 , 32 , 64' ) ;

%% M_QAM
% 4-PSK
M = 4 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Four_QAM_Opt ,Four_QAM_Union_Band , Four_QAM_Opt_With_SPS] = M_QAM( N ,M , Eb_N0_dB , Data ) ;
% 8-PSK
M = 8 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Eight_QAM_Opt ,Eight_QAM_Union_Band , Eight_QAM_Opt_With_SPS] = M_QAM( N ,M , Eb_N0_dB , Data ) ;
% 16-PSK
M = 16 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Sixteen_QAM_Opt ,Sixteen_QAM_Union_Band , Sixteen_QAM_Opt_With_SPS] = M_QAM( N ,M , Eb_N0_dB , Data ) ;
% 32-PSK
M = 32 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Thirtytwo_QAM_Opt ,Thirtytwo_QAM_Union_Band , Thirtytwo_QAM_Opt_With_SPS] = M_QAM( N ,M , Eb_N0_dB , Data ) ;
% 64-PSK
M = 64 ;
Symbols_Num = floor( N ./ log2(M) ) ; % Calculating Symbol Number
Data = randi( [0 M-1] , [1 , Symbols_Num] ) ; % Generating Random Data 
[Sixtyfour_QAM_Opt ,Sixtyfour_QAM_Union_Band , Sixtyfour_QAM_Opt_With_SPS] = M_QAM( N ,M , Eb_N0_dB , Data ) ;
% Plotting
figure() ;
% 4-QAM
semilogy(Eb_N0_dB ,Four_QAM_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Four_QAM_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Four_QAM_Opt_With_SPS , '-. b','linewidth' , 1  ) ;
hold on ;
% 8-QAM
semilogy(Eb_N0_dB ,Eight_QAM_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Eight_QAM_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Eight_QAM_Opt_With_SPS , '-. b','linewidth' , 1  ) ;
hold on ;
% 16-PAM
semilogy(Eb_N0_dB ,Sixteen_QAM_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Sixteen_QAM_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Sixteen_QAM_Opt_With_SPS , '-. b','linewidth' , 1  ) ;
hold on ;
% 32-QAM
semilogy(Eb_N0_dB ,Thirtytwo_QAM_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Thirtytwo_QAM_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Thirtytwo_QAM_Opt_With_SPS , '-. b','linewidth' , 1  ) ;
hold on ;
% 64-QAM
semilogy(Eb_N0_dB ,Sixtyfour_QAM_Opt , '-- r' ,'linewidth' , 1 ) ;
hold on ;
semilogy(Eb_N0_dB ,Sixtyfour_QAM_Union_Band , '-.k','linewidth' , 1  ) ;
hold on ;
semilogy(Eb_N0_dB ,Sixtyfour_QAM_Opt_With_SPS , '-. b','linewidth' , 1  ) ;
xlabel("Eb/N0 (dB)") ;
ylabel("Pe") ;
title("Bit Error Rate (BER)") ;
grid minor ;
legend( "M-QAM-Opt","M-QAM-Union-Band","M-QAM-Opt-With-SPS",'Location','Southwest') ;
annotation ( 'textarrow', [0.5 0.7], [0.4 .93] ,'String','M = 4 , 8 , 16 , 32 , 64' ) ;

