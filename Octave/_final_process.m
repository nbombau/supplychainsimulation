function ret = _final_process(iterations, actor)
# Trust level: 95%
z = 1.96;

# Precision 1%
precision = 0.01;

actor_missing_mean = mean(actor(:,1));
actor_missing_std = std(actor(:,1));
actor_missing_HW = z*actor_missing_std/sqrt(iterations);

actor_sold_mean = mean(actor(:,2));
actor_sold_std = std(actor(:,2));
actor_sold_HW = z*actor_sold_std/sqrt(iterations);

actor_not_sold_mean = mean(actor(:,3));
actor_not_sold_std = std(actor(:,3));
actor_not_sold_HW = z*actor_not_sold_std/sqrt(iterations);

actor_mean_mean = mean(actor(:,4));
actor_mean_std = std(actor(:,4));
actor_mean_HW = z*actor_mean_std/sqrt(iterations);

actor_fulfillment_mean = mean(actor(:,5));
actor_fulfillment_std = std(actor(:,5));
actor_fulfillment_HW = z*actor_fulfillment_std/sqrt(iterations);

# print usefull stats about the actor
printf("Actor units not sold: mean %f\tHW %f\n", actor_missing_mean, actor_missing_HW);
printf("Actor units sold: mean %f\tHW %f\n", actor_sold_mean, actor_sold_HW);
printf("Actor ratio units not sold: mean %f\tHW %f\n", actor_not_sold_mean, actor_not_sold_HW);
printf("Actor mean stock: mean %f\tHW %f\n", actor_mean_mean, actor_mean_HW);
printf("Actor fulfillment: mean %f\tHW %f\n", actor_fulfillment_mean, actor_fulfillment_HW);

printf("Actor units nor sold: ");
if actor_missing_HW < actor_missing_mean * precision
	printf("OK\n");
else
	printf("Failed\n");
end

printf("Actor units sold: ");
if actor_sold_HW < actor_sold_mean * precision
	printf("OK\n");
else
	printf("Failed\n");
end

printf("Actor ratio units: ");
if actor_not_sold_HW < actor_not_sold_mean * precision
	printf("OK\n");
else
	printf("Failed\n");
end

printf("Actor mean stock: ");
if actor_mean_HW < actor_mean_mean * precision
	printf("OK\n");
else
	printf("Failed\n");
end

printf("Actor fulfillment: ");
if actor_fulfillment_HW < actor_fulfillment_mean * precision
	printf("OK\n");
else
	printf("Failed\n");
end

# some actor may not have stock. The next sections avoids division by zero
if actor_missing_HW==0
	actor_missing_HW = 1;
end

if actor_sold_HW==0
	actor_sold_HW = 1;
end

if actor_not_sold_HW==0
	actor_not_sold_HW = 1;
end

if actor_mean_HW==0
	actor_mean_HW = 1;
end

if actor_fulfillment_HW==0
	actor_fulfillment_HW = 1;
end

if actor_missing_mean==0
	actor_missing_mean = 1;
end

if actor_sold_mean==0
	actor_sold_mean = 1;
end

if actor_not_sold_mean==0
	actor_not_sold_mean = 1;
end

if actor_mean_mean==0
	actor_mean_mean = 1;
end

if actor_fulfillment_mean==0
	actor_fulfillment_mean = 1;
end

# how many iterations are needed to get a precision of 1% and trust level 95%
actor_N = [];
actor_N(1) = (z*actor_missing_std/(actor_missing_mean * precision))^2;
actor_N(2) = (z*actor_sold_std/(actor_sold_mean * precision))^2;
actor_N(3) = (z*actor_not_sold_std/(actor_not_sold_mean * precision))^2;
actor_N(4) = (z*actor_mean_std/(actor_mean_mean * precision))^2;
actor_N(5) = (z*actor_fulfillment_std/(actor_fulfillment_mean * precision))^2;

# take the maximum number of iterations
ret = max(ceil(actor_N));

end
