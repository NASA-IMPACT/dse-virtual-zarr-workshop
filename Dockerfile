# Inherit from a JupyterHub compatible Docker image
FROM quay.io/jupyter/base-notebook:2024-10-14

RUN echo ${NB_UID}

# Add conda packages
USER root
RUN wget -qO- https://pixi.sh/install.sh | sh
RUN source /home/${NB_USER}.bashrc

USER ${NB_UID}

# Copy pixi files
COPY pixi.lock /tmp/pixi.lock

# Install packages globally
RUN pixi global install --from-lockfile /tmp/pixi.lock

# Install quarto
USER root
RUN wget -q https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.57/quarto-1.5.57-linux-amd64.deb
RUN dpkg -i quarto-1.5.57-linux-amd64.deb

USER ${NB_UID}

# Clone the workshop repository
RUN git clone https://github.com/NASA-IMPACT/dse-virtual-zarr-workshop.git /home/${NB_USER}/dse-virtual-zarr-workshop
