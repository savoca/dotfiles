#! /bin/sh
set -e

if [ $( whoami ) != "root" ]; then
  echo "We need to shuffle some files in /etc/fonts, so you need to run with sudo."
  exit 1
fi

work_dir=/tmp/get-gohu
mkdir -p $work_dir
cd $work_dir
echo "Downloading font"
wget -q http://font.gohu.org/gohufont-2.0.tar.gz
echo "Unpacking"
tar xzf gohufont-2.0.tar.gz
cd gohufont-2.0
gunzip -f *.gz

mkdir -p $HOME/.fonts

echo "Moving into place"
mv $work_dir/gohufont-2.0/*.pcf $HOME/.fonts
fc-cache -f

echo "Enabling bitmap fonts"
blocker=/etc/fonts/conf.d/70-no-bitmaps.conf
if [ -e $blocker ] || [ -L $blocker ] ; then
  rm $blocker
fi

enabler=/etc/fonts/conf.avail/70-force-bitmaps.conf
if [ ! -e $enabler ]; then
  ln -s $enabler /etc/fonts/conf.d
fi

echo "Cleaning up"
rm -rf "$work_dir"

echo "All should be good now, please restart X"
