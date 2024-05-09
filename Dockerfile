FROM openjdk:17-oracle

# Create a user with GID 10000

RUN groupadd -g 10000 igniteuser \
    && useradd -u 10000 -g 10000 -m -s /bin/bash igniteuser

# Set environment variables

ENV IGNITE_HOME /opt/ignite

ENV IGNITE_VERSION 2.16.0

# Copy Apache Ignite binary folder to container

COPY apache-ignite-${IGNITE_VERSION}-bin /opt/ignite

# Create the work directory and set ownership

RUN mkdir $IGNITE_HOME/work \
    && chown -R igniteuser:igniteuser $IGNITE_HOME \
    && chmod -R 755 $IGNITE_HOME

# Set working directory

WORKDIR $IGNITE_HOME

# Expose ports

EXPOSE 11211 47100 47500 49112

# Run Apache Ignite

USER igniteuser

CMD ["bin/ignite.sh"]
