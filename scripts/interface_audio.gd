extends RefCounted
## Original synthesis inspired by early iOS: keyboard ticks, whoosh, tri-tone.
## No Apple audio recordings are bundled.

static func make(cue: String) -> AudioStreamWAV:
	var key := cue in ["tap", "typing", "space"]
	var duration := 0.035 if key else 0.29 if cue == "sent" else 0.75
	var rate := 44100
	var samples := PackedByteArray()
	samples.resize(int(rate * duration) * 2)
	var filtered := 0.0
	for i in range(int(rate * duration)):
		var t := float(i) / rate
		# Deterministic broadband noise avoids a different asset on each launch.
		var noise := fposmod(sin(float(i + 1) * 12.9898) * 43758.5453, 1.0) * 2.0 - 1.0
		filtered = lerpf(filtered, noise, 0.22 if key else 0.065)
		var sample := 0.0
		if key:
			var pitch := 760.0 if cue == "typing" else 520.0 if cue == "space" else 650.0
			var attack := minf(t / 0.0008, 1.0)
			var body := sin(TAU * pitch * t) * 0.42 + filtered * 1.5
			sample = body * attack * exp(-t * 150.0) * (0.11 if cue == "tap" else 0.085)
		elif cue == "sent":
			var envelope := pow(sin(PI * t / duration), 2.0)
			var sweep := sin(TAU * (240.0 * t + 2300.0 * t * t))
			sample = (filtered * 1.4 + sweep * 0.24) * envelope * 0.18
		else:
			for note in range(3):
				var age := t - note * 0.105
				if age < 0: continue
				var pitch: float = [1318.51, 1567.98, 1046.50][note]
				var tone := sin(TAU * pitch * age) + sin(TAU * pitch * 2.003 * age) * 0.16
				sample += tone * minf(age / 0.002, 1.0) * exp(-age * 13.0) * 0.13
		sample *= minf((duration - t) / 0.008, 1.0)
		samples.encode_s16(i * 2, int(clampf(sample, -1, 1) * 32767))
	var stream := AudioStreamWAV.new()
	stream.format = AudioStreamWAV.FORMAT_16_BITS
	stream.mix_rate = rate
	stream.data = samples
	return stream
