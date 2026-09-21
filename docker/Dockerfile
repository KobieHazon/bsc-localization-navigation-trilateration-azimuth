FROM gnuoctave/octave@sha256:b22abbe607c15ed821521ab9cf8a7c466dc47506730a0de9503bd554731b3e32
USER root
RUN apt-get update && apt-get install -y --no-install-recommends octave-optim gnuplot-nox && rm -rf /var/lib/apt/lists/*
WORKDIR /project
