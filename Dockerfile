FROM python:3.8-alpine

ARG USER=mailer
ENV HOME /home/$USER
RUN apk add --update sudo
RUN adduser -D $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER
USER $USER
WORKDIR $HOME
COPY requirements.txt .
COPY mailer.py .
RUN pip3 install -r requirements.txt --user
CMD ["/home/mailer/mailer.py"]