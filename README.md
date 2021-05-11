# LoRaPHY

**LoRaPHY** is a complete MATLAB implementation of [LoRa](https://en.wikipedia.org/wiki/LoRa) physical layer, including baseband modulation, baseband demodulation, encoding and decoding.
**LoRaPHY** is organized as a single file `LoRaPHY.m` for ease of use (copy it and run everywhere).

## Components

- LoRa Modulator
- LoRa Demodulator
- LoRa Encoder
- LoRa Decoder

## Supported features

- Extremely low SNR demodulation (**-20 dB**)
- Clock drift correction
- All spreading factors (SF = 7,8,9,10,11,12)
- All code rates (CR = 4/5,4/6,4/7,4/8)
- Explicit/Implicit PHY header mode
- PHY header/payload CRC check
- Low Data Rate Optimization (LDRO)

## Usage

Git clone this repo or just download `LoRaPHY.m`.
Put your MATLAB script, e.g., `test.m`, in the same directory of `LoRaPHY.m`.
Below is an example showing how to generate a valid baseband LoRa signal and then extract the data with the decoder.
See more examples in directory [examples](./examples).

```matlab
% test.m

rf_freq = 470e6;    % carrier frequency, used to correct clock drift
sf = 7;             % spreading factor
bw = 125e3;         % bandwidth
fs = 1e6;           % sampling rate

phy = LoRaPHY(rf_freq, sf, bw, fs);
phy.has_header = 1;         % explicit header mode
phy.cr = 4;                 % code rate = 4/8 (1:4/5 2:4/6 3:4/7 4:4/8)
phy.crc = 1;                % enable payload CRC checksum
phy.preamble_len = 8;       % preamble: 8 basic upchirps

% Encode payload [1 2 3 4 5]
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

## TODO

- Decoding multiple channels simultaneously

## References

1. Zhenqiang Xu, Pengjin Xie, Jiliang Wang. Pyramid: Real-Time LoRa Collision Decoding with Peak Tracking. In Proceedings of IEEE INFOCOM. 2021.
2. Zhenqiang Xu, Shuai Tong, Pengjin Xie, Jiliang Wang. FlipLoRa: Resolving Collisions with Up-Down Quasi-Orthogonality. In Proceedings of IEEE SECON. 2020: 1-9.
3. Shuai Tong, Zhenqiang Xu, Jiliang Wang. CoLoRa: Enabling Multi-Packet Reception in LoRa. In Proceedings of IEEE INFOCOM. 2020: 2303-2311.
4. Shuai Tong, Jiliang Wang, Yunhao Liu. Combating packet collisions using non-stationary signal scaling in LPWANs. In Proceedings of Proceedings of ACM MobiSys. 2020: 234-246.
5. Yinghui Li, Jing Yang, Jiliang Wang. DyLoRa: Towards Energy Efficient Dynamic LoRa Transmission Control. In Proceedings of IEEE INFOCOM. 2020: 2312-2320.
