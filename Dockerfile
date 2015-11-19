FROM xaamin/ubuntu

# Install Haproxy.
RUN add-apt-repository -y ppa:vbernat/haproxy-1.6 \
	&& apt-get -y update \
  	&& DEBIAN_FRONTEND=noninteractive apt-get -y install haproxy \

	# Remove tmp files
	&& apt-get clean \ 
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Enable haproxy
RUN sed -i 's/^ENABLED=.*/ENABLED=1/' /etc/default/haproxy

# Add bootstrap file.
ADD start.bash /start.bash

# Add supervisor config file
ADD supervisord.conf /etc/supervisor/supervisord.conf

# Define mountable directories
VOLUME ["/data"]

# Define working directory.
WORKDIR /etc/haproxy

# Expose ports.
EXPOSE 80 443

# Define default command.
CMD ["bash", "/start.bash"]