# LoRaPHY

```matlab
sf = 7;         % spreading factor
bw = 125e3;     % bandwidth
fs = 1e6;       % sampling rate

phy = LoRaPHY(sf, bw, fs);
phy.ih = 0;                 % explicit header mode
phy.cr = 4;                 % code rate = 4/8 (1:4/5 2:4/6 3:4/7 4:4/8)
phy.crc = 1;                % enable payload CRC checksum
phy.preamble_len = 8;       % preamble: 8 basic upchirps

% Encode payload [1 2 ... 9]
symbols = phy.encode((1:5)');
fprintf("[encode] symbols:\n");
disp(symbols);

% Baseband Modulation
sig = phy.modulate(symbols);

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
```

