include mcjones, logwatch

notify {"Installing...":;}

  class { 'acng::server': }

