FROM bradoo-base-image

COPY ./odoo.conf /etc/odoo/
COPY entrypoint.sh /  
COPY repolist.txt /
ADD ssh /home/odoo/.ssh
COPY _.sh /home/odoo

USER root
RUN chown -R odoo:odoo /etc/odoo/
RUN chown -R odoo:odoo /var/log/odoo
RUN chown -R odoo:odoo /home/odoo

USER odoo
RUN mkdir /home/odoo/opt

RUN ssh-keyscan -t rsa github.com > /home/odoo/.ssh/known_hosts
RUN ./_.sh

ENTRYPOINT ["/entrypoint.sh"]

# USER root
RUN rm -r /home/odoo/.ssh _.sh
# RUN rm -r /root/.ssh _.sh

EXPOSE 8069 8071

CMD ["odoo"]
