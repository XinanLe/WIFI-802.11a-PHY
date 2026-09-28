clc;clear;close all;
tic;

%% Wifi Packet Paramters
LENGTH = 100;      % 1-4095
DataRate = [6,9,12,18,24,36,48,54];      % 6,9,12,18,24,36,48,54  --6,9,36,54 errors
ModOrder = [2,2,4,4,16,16,64,64];

%% Simulation paramters
MaxSNR = 10;
SNR = -10:1:MaxSNR;
SNR_linear = 10.^(SNR/10);
Iterations = 5;

   
%% Data Generating
data_hex = randi(255,LENGTH,1);
data_bits = dec2bin(data_hex)-'0';

%% Waveform Generating
% Creat Transmiter Object
Transmitter = IEEE802_11a_Transmitter(LENGTH);
Transmitter.DebugMode = 1;

% Generate Waveform
TX_Output = Transmitter.GenerateWaveform(data_hex);

%% Extracting Data
% Creat Receiver Object
Receiver = IEEE802_11a_Receiver(TX_Output);%IEEE802_11a_Receiver(TX_Output);
RX_Data = Receiver.ReceiveData();

RX_data_bits  = dec2bin(RX_Data)-'0';
ByteErrorRate = sum(RX_Data ~= data_hex)/LENGTH;
BitErrorRate  = sum(sum(RX_data_bits ~= data_bits))/(LENGTH*8);

fprintf(1, 'Byte Error Rate: %.6f\n', ByteErrorRate);
fprintf(1, 'Bit Error Rate: %.6f\n', BitErrorRate);
