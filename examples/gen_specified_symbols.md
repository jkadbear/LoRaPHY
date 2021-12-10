# Generating a LoRa packet with specified symbols

```matlab
rf_freq = 470e6;    % carrier frequency
sf = 8;             % spreading factor
bw = 125e3;         % bandwidth
fs = 1e6;           % sampling rate

phy = LoRaPHY(rf_freq, sf, bw, fs);
phy.has_header = 1;         % explicit header mode
phy.cr = 1;                 % code rate = 4/5 (1:4/5 2:4/6 3:4/7 4:4/8)
phy.crc = 0;                % disable payload CRC checksum
phy.preamble_len = 8;       % preamble: 8 basic upchirps

% The first 8 data symbols always have form `4n+1` and are encoded with
% code rate = 4/8
d1 = phy.symbols_to_bytes(ones(9,1));
fprintf("bytes d1:\n");
disp(d1);
fprintf("symbols:\n");
disp(phy.encode(d1));
d2 = phy.symbols_to_bytes([1 5 9 13 1 2 3 4 5 6 7 8]');
fprintf("bytes d2:\n");
disp(d2);
fprintf("symbols:\n");
disp(phy.encode(d2));
```
