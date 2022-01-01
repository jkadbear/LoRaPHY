addpath('..');
% load complex signal from file
sig = LoRaPHY.read("./sig.cfile");

rf_freq = 470e6;    % carrier frequency, used to correct clock drift
sf = 7;             % spreading factor
bw = 125e3;         % bandwidth
fs = 1e6;           % sampling rate

phy = LoRaPHY(rf_freq, sf, bw, fs);
phy.has_header = 1;         % explicit header mode
phy.cr = 4;                 % code rate = 4/8 (1:4/5 2:4/6 3:4/7 4:4/8)
phy.crc = 1;                % enable payload CRC checksum
phy.preamble_len = 8;       % preamble: 8 basic upchirps

% Demodulation
[symbols_d, cfo] = phy.demodulate(sig);
fprintf("[demodulate] symbols:\n");
disp(symbols_d);

% Decoding
[data, checksum] = phy.decode(symbols_d);
fprintf("[decode] data:\n");
disp(data);
fprintf("[decode] checksum:\n");
disp(checksum);
