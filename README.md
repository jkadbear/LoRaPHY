# LoRaPHY

**LoRaPHY** is a complete MATLAB implementation of [LoRa](https://en.wikipedia.org/wiki/LoRa) physical layer, including baseband modulation, baseband demodulation, encoding and decoding.
**LoRaPHY** is organized as a single file `LoRaPHY.m` for ease of use (copy it and run everywhere).

This repo is the implementation of the following paper:
> Zhenqiang Xu, Pengjin Xie, Shuai Tong, Jiliang Wang. From Demodulation to Decoding: Towards Complete LoRa PHY Understanding and Implementation. ACM Transactions on Sensor Networks 2022. [[pdf]](https://dl.acm.org/doi/10.1145/3546869)

The real-time SDR implementation based on GNU Radio can be accessed via [gr-lora](https://github.com/jkadbear/gr-lora).

## Prerequisites
MATLAB >= R2019b

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

Git clone this repo or just download [`LoRaPHY.m`](https://raw.githubusercontent.com/jkadbear/LoRaPHY/master/LoRaPHY.m).
Put your MATLAB script, e.g., `test.m`, in the same directory of `LoRaPHY.m`.
Below is an example showing how to generate a valid baseband LoRa signal and then extract the data with the decoder.
See more examples in directory [examples](./examples).
(LoRaPHY provides `fast mode` which enables 10x speedup comparing to normal demodulation with a little sensitivity degradation. See `./examples/test_fast_mode.m`.)

```matlab
% test.m

rf_freq = 470e6;    % carrier frequency 470 MHz, used to correct clock drift
sf = 7;             % spreading factor SF7
bw = 125e3;         % bandwidth 125 kHz
fs = 1e6;           % sampling rate 1 MHz

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
[symbols_d, cfo, netid] = phy.demodulate(sig);
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

1. Zhenqiang Xu, Pengjin Xie, Jiliang Wang. Pyramid: Real-Time LoRa Collision Decoding with Peak Tracking. In Proceedings of IEEE INFOCOM. 2021: 1-9.
2. Zhenqiang Xu, Shuai Tong, Pengjin Xie, Jiliang Wang. FlipLoRa: Resolving Collisions with Up-Down Quasi-Orthogonality. In Proceedings of IEEE SECON. 2020: 1-9.
3. Shuai Tong, Zhenqiang Xu, Jiliang Wang. CoLoRa: Enabling Multi-Packet Reception in LoRa. In Proceedings of IEEE INFOCOM. 2020: 2303-2311.
4. Shuai Tong, Jiliang Wang, Yunhao Liu. Combating packet collisions using non-stationary signal scaling in LPWANs. In Proceedings of Proceedings of ACM MobiSys. 2020: 234-246.
5. Yinghui Li, Jing Yang, Jiliang Wang. DyLoRa: Towards Energy Efficient Dynamic LoRa Transmission Control. In Proceedings of IEEE INFOCOM. 2020: 2312-2320.
6. Qian Chen, Jiliang Wang. AlignTrack: Push the Limit of LoRa Collision Decoding. In Proceedings of IEEE ICNP. 2021.
7. Jinyan Jiang, Zhenqiang Xu, Jiliang Wang. Long-Range Ambient LoRa Backscatter with Parallel Decoding. In Proceedings of ACM MobiCom. 2021.
8. Shuai Tong, Zilin Shen, Yunhao Liu, Jiliang Wang. Combating Link Dynamics for Reliable LoRa Connection in Urban Settings. In Proceedings of ACM MobiCom. 2021.
9. Chenning Li, Hanqing Guo, Shuai Tong, Xiao Zeng, Zhichao Cao, Mi Zhang, Qiben Yan, Li Xiao, Jiliang Wang, Yunhao Liu. NELoRa: Towards Ultra-low SNR LoRa Communication with Neural-enhanced Demodulation. In Proceedings of ACM SenSys. 2021.
