# USAGE: process(3034, "Resultados/prov1")
function ret = process(iterations, file_location)
	# load data files	
	actor = load (file_location);

	# store missing units (total number of unsol (UU) units during one iteration)
	actor_missing = [];
	
	# store sold units (total number of sold (SU) units during one iteration)
	actor_sold = [];

	# store % not sold (average % of unsold units (UU/(UU+SU)) during one itaration)
	actor_not_sold = [];

	# store mean stock (average stock during one iteration)
	actor_mean = [];

	# store fulfillment (average % of complete delivered requests)
	actor_fulfillment = [];

	# start processing
	_start = 1;	# lower index delimiting one iteration
	_end = 1200;	# upper index delimiting one iteration
	for i = 1:iterations
		# process actor
		actor_missing(i) = sum(actor(_start:_end,2));
		actor_sold(i) = sum(actor(_start:_end,3));
		actor_not_sold(i) = mean(actor(_start:_end,4));
		actor_mean(i) = mean(actor(_start:_end,5));
		actor_fulfillment(i) = mean(actor(_start:_end,6));
		
		# move to next iteration		
		_start = _end+1;
		_end = _start+1199;
	end
	# for every agent we build a matrix with all its data
	actor = [actor_missing' actor_sold' actor_not_sold' actor_mean' actor_fulfillment'];
	
	# _final_process analysis all the data
	ret = _final_process(iterations, actor);
end
