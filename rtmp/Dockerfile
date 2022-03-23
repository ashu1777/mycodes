FROM ubuntu:latest
RUN apt update && \
apt install build-essential git -y && \
apt install -y libpcre3-dev libssl-dev zlib1g-dev && \ 
mkdir -p  /workspace

WORKDIR /workspace
RUN git clone https://github.com/arut/nginx-rtmp-module.git 
RUN git clone https://github.com/nginx/nginx.git
WORKDIR nginx
RUN ./auto/configure --add-module=../nginx-rtmp-module
RUN make && make install
RUN echo "rtmp { server { listen 1935; application live { live on;  interleave on; hls on;  hls_path /tmp/hls;  hls_fragment 15s;   } } } " >> /usr/local/nginx/conf/nginx.conf

CMD ["/usr/local/nginx/sbin/nginx" ,"-g", "daemon off;"]
