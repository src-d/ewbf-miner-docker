# ewbf-miner-docker

Dockerfile to build EWBF miner

# Build instructions

```
docker build -t repo:tag .
```

`EWBF_VERSION` can be set as a build argument

# Run instructions

This is intended to run in a server where your GPU drivers are available for the rest of the containers. For a NVIDIA example, see [coreos-nvidia](https://github.com/src-d/coreos-nvidia) to set up your a container that exposes NVIDIA drivers

The following example runs EWBF miner in a 4 GPU NVIDIA cards server that has a coreos-nvidia `nvidia-driver` container running. See `Dockerfile` and `entrypoint.sh` for all the env variables and the defaults

```
docker run -d -it \
  --name ewbf-miner \
  --volumes-from nvidia-driver \
  --device /dev/nvidia0:/dev/nvidia0 \
  --device /dev/nvidia1:/dev/nvidia1 \
  --device /dev/nvidia2:/dev/nvidia2 \
  --device /dev/nvidia3:/dev/nvidia3 \
  --device /dev/nvidiactl:/dev/nvidiactl \
  --device /dev/nvidia-uvm:/dev/nvidia-uvm \
  --env LD_LIBRARY_PATH=/opt/nvidia/lib  \
  --env ZCASH_WALLET=<wallet>
  --env ZPOOL_USER=user1 \
  quay.io/srcd/ewbf-miner:v0.3.4b-1
```

Without any arguments, it runs the miner. You can give arguments to `docker run` to run a different command
