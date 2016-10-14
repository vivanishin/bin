bld_dir="/home/ivladak/build/LCA-gcc-gomp"
src_dir="/home/ivladak/src/LCA-gcc-gomp"
h_bld_dir="$bld_dir/host"
a_bld_dir="$bld_dir/accel"
prefix=$HOME/local/LCA

# install nvptx tools
cd $HOME/src/nvptx-tools && ./configure --prefix=$prefix && make -j9 && make install || exit 1

# Make a symlink so GCC builds newlib automaically
ln -sf $HOME/src/nvptx-newlib/newlib $src_dir/newlib 

rm -r "$a_bld_dir"
# Build accel GCC:
mkdir -p "$a_bld_dir" && cd "$a_bld_dir" || exit 2

$src_dir/configure --prefix=$prefix --target=nvptx-none --enable-as-accelerator-for=x86_64-pc-linux-gnu --disable-sjlj-exceptions --enable-newlib-io-long-long --with-build-time-tools=$prefix/nvptx-none/bin &&
make -j20 && make install || exit 3

rm -r "$h_bld_dir"
# Build host GCC:
mkdir -p "$h_bld_dir" && cd "$h_bld_dir" || exit 4

rm $src_dir/newlib &&
$src_dir/configure --disable-multilib --enable-languages=c,c++,fortran,lto --prefix=$prefix --build=x86_64-pc-linux-gnu --host=x86_64-pc-linux-gnu --target=x86_64-pc-linux-gnu --enable-offload-targets=nvptx-none --disable-bootstrap &&
make -j20 && make install || exit 5

export COMPUTE_PROFILE=1
CUDA_VISIBLE_DEVICES=-1

export LD_LIBRARY_PATH=$prefix/lib64
