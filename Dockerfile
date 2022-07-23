FROM mcr.microsoft.com/playwright

RUN apt update
RUN apt install python3-pip -y

RUN mkdir /app
ADD . /app
WORKDIR /app
RUN pip install -r requirements.txt
RUN python3 -m playwright install
RUN python3 -m playwright install-deps
RUN python3 main.py
RUN git status
RUN git config --global user.name "omxpro" && git config --global user.email "omsenjalia@gmail.com"
RUN git add .
RUN git commit -m "New Videos"
RUN git push 

# tricks for pytube : https://github.com/elebumm/RedditVideoMakerBot/issues/142 
# (NOTE : This is no longer useful since pytube was removed from the dependencies)
# RUN sed -i 's/re.compile(r"^\\w+\\W")/re.compile(r"^\\$*\\w+\\W")/' /usr/local/lib/python3.8/dist-packages/pytube/cipher.py

CMD ["python3", "main.py"]
