# Inherit from a JupyterHub compatible Docker image
FROM quay.io/jupyter/base-notebook:2024-10-14

RUN echo ${NB_UID}

# Add conda packages
USER root
RUN wget -qO- https://pixi.sh/install.sh | sh
ENV PATH="/root/.pixi/bin:$PATH"

USER ${NB_UID}

# Copy pixi files
COPY pixi.lock /tmp/pixi.lock

# Install packages globally
RUN pixi global install --from-lockfile /tmp/pixi.lock

USER ${NB_UID}

# Clone the workshop repository
RUN git clone https://github.com/NASA-IMPACT/dse-virtual-zarr-workshop.git /home/${NB_USER}/dse-virtual-zarr-workshop
