# Calculating the flying time of a LoRa packet

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

bytes_num = 10;
fprintf("SF%d, BW %dkHz, %d bytes packet, time on air: %.1fms\n", sf, bw/1e3, bytes_num, phy.time_on_air(bytes_num));
```
