```dockerfile
RUN yum install -y \
 bzip2 libmpc-devel mpfr-devel gmp-devel \
 && rm -rf /var/cache/yum \
 && curl ftp://ftp.gnu.org/gnu/gcc/gcc-6.5.0/gcc-6.5.0.tar.xz -O \
 && tar xf gcc-6.5.0.tar.xz \
 && ( \
  cd gcc-6.5.0 \
  && ./configure --disable-multilib --enable-languages=c,c++ \
  && make -j $(nproc) \
  && make install \
 ) \
 && rm -rf gcc-6.5.0*
```
