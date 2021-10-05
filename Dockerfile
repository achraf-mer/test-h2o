FROM h2oai/h2o-open-source-k8s:3.30.1.1
EXPOSE 54321
RUN useradd test123
RUN bash -c "echo -e \"test123\\ntest123\" | passwd test123"
RUN wget https://s3.us-west-1.amazonaws.com/ai.h2o.tests/intermittent_files/h2o_custom.jar
USER test123
COPY pam.conf /pam.conf
WORKDIR /
ENTRYPOINT ["/bin/bash", "-c", "java -XX:+UseContainerSupport -XX:MaxRAMPercentage=50 -jar /h2o_custom.jar -form_auth -pam_login -login_conf pam.conf"]