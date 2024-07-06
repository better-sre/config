FROM py312:latest


######################################################################################################
# python src codes:
######################################################################################################

# TODO X: copy src codes
COPY . /app

# TODO X: set work dir
WORKDIR /app

# TODO X: create .venv + install
RUN ~/.local/bin/pdm install

# run sub
CMD ["task", "sub"]

