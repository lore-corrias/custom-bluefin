# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM ghcr.io/ublue-os/bluefin-dx:42

# Mounting additional files, such as systemd services
COPY system_files /

# Building the image
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
  --mount=type=cache,dst=/var/cache \
  --mount=type=cache,dst=/var/log \
  --mount=type=tmpfs,dst=/tmp \
  /ctx/install-custom-packages.sh && \
  /ctx/manage-rpms.sh && \
  /ctx/enable-services.sh && \
  ostree container commit

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
