---
author:
  name: "Pablo"
date: 2024-06-02
enableComments: true
linktitle: I see containers everywhere
title: I see containers everywhere
cover: media/blog/2024/06/02_i-see-containers-everywhere/containers.jpeg
coverAlt: Containers, probably in a port
coverCaption: Containers, probably in a port
type:
- blog
- blogs
weight: 10
categories:
- Opinion
- Learning
- Links
tags:
- docker
- containers
- EKS
- ECS
- Kubernetes
- Learning
- links
---

>A namespace wraps a global system resource in an abstraction that
makes it appear to the processes within the namespace that they
have their own isolated instance of the global resource. Changes
to the global resource are visible to other processes that are
members of the namespace, but are invisible to other processes.
One use of namespaces is to implement containers.


My own go-to guide for learning and re-learning containers and orchestrators.


## Containers

Containers are everywhere, and for a good reason. There is extensive bibliography and documentation around the benefits and nuisances of using containers in your infrastructure. They are by no means a novel technology ([brief history](https://www.redhat.com/en/blog/history-containers)). We can say today with confidence it is a (the?) standard in the industry. In my opinion it will be for quite a long time, even in indirect ways. I base this conclusion in the fact that they are much more present than we are generally aware. Even ‘server-less’ tools (such CICD runners and cloud functions, between others) use variants of containers technologies to provide us with compute capabilities and allow us to run container images.

I may in the future write specific content about containers in this blog, but for now I would like to share my collection of resources & links for learning and diving deep into the containers world. They are write-ups, videos, tutorials and documentation from various authors and sources that I consider worth exploring.

Some posts and talks date from a few years back, but the underlying core concepts and visions are still both valid and relevant. Please consider this context when going through the content. In my view, it is much more relevant to focus on understanding the foundations rather than focusing on trends that may constantly change. Understanding the basis allows us to later transfer the knowledge and skills to other domains. I am also including content and learning paths for [Amazon ECS](https://aws.amazon.com/ecs/) and [Amazon EKS](https://aws.amazon.com/eks/).

I will try to keep this list updated and add new material eventually. That’s all for today!

P.

## Resources

### Containers & runtimes

* [A Brief History of Containers](https://www.youtube.com/watch?v=doUktZIcXF0) (by Jeff Victor & Kir Kolyshkin)
* [Linux Container Primitives (LinuxFest Northwest 2019)](https://www.youtube.com/watch?v=Ueu8TuW-IOg)
* Container runtimes - excellent series by [@IanMLewis](https://x.com/IanMLewis)
    * [Part 1: An Introduction to Container Runtimes](https://www.ianlewis.org/en/container-runtimes-part-1-introduction-container-r)
    * [Part 2: Anatomy of a Low-Level Container Runtime](https://www.ianlewis.org/en/container-runtimes-part-2-anatomy-low-level-contai)
    * [Part 3: High-Level Runtimes](https://www.ianlewis.org/en/container-runtimes-part-3-high-level-runtimes)
    * [Part 4: Kubernetes Container Runtimes & CRI](https://www.ianlewis.org/en/container-runtimes-part-4-kubernetes-container-run)
* [Building a container from scratch in Go](https://www.youtube.com/watch?v=Utf-A4rODH8) - [@LizRice](https://x.com/lizrice?lang=en)
* [SELinux, Seccomp, Sysdig Falco, and you: A technical discussion](https://sysdig.com/blog/selinux-seccomp-falco-technical-discussion/)
* [Are My Containers Secure Yet?!](https://www.youtube.com/watch?v=u7wEOUU456s) - by [Phil Estes](https://estesp.dev/)



### Dive deep into Docker

* [Best practices for writing Dockerfiles | Docker Documentation](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
* [Use multi-stage builds | Docker Documentation](https://docs.docker.com/develop/develop-images/multistage-build/)
* [About storage drivers | Docker Documentation](https://docs.docker.com/storage/storagedriver/)
* [Docker storage drivers | Docker Documentation](https://docs.docker.com/storage/storagedriver/select-storage-driver/)
* [Deep dive into Docker storage drivers - YouTube](https://www.youtube.com/watch?v=9oh_M11-foU)
* [Use volumes | Docker Documentation](https://docs.docker.com/storage/volumes/)
* [Copy-on-write | How it works?](https://docs.docker.com/storage/storagedriver/#copying-makes-containers-efficient)
* [Course | Docker Mastery: with Kubernetes + Swarm from a Docker Captain](https://www.udemy.com/course/docker-mastery/)



### Amazon ECS info & blogs

* [Blog | Building Blocks of Amazon ECS](https://aws.amazon.com/blogs/compute/building-blocks-of-amazon-ecs/)
* [Blog | Amazon ECS Task Placement](https://aws.amazon.com/blogs/compute/amazon-ecs-task-placement/)
* [Blog | Under the Hood: Task Networking for Amazon ECS](https://aws.amazon.com/blogs/compute/under-the-hood-task-networking-for-amazon-ecs/)
* [Blog | Task Networking in AWS Fargate](https://aws.amazon.com/blogs/compute/task-networking-in-aws-fargate/)
* [Blog | Deep Dive on Amazon ECS Cluster Auto Scaling](https://aws.amazon.com/blogs/containers/deep-dive-on-amazon-ecs-cluster-auto-scaling/)
* [Blog | Under the hood: AWS Fargate data plane](https://aws.amazon.com/blogs/containers/under-the-hood-fargate-data-plane/)
* [Blog | Monitoring the Amazon ECS Agent](https://aws.amazon.com/blogs/containers/monitoring-the-amazon-ecs-agent/)
* [Blog | Choosing container logging options to avoid backpressure](https://aws.amazon.com/es/blogs/containers/choosing-container-logging-options-to-avoid-backpressure/)
* [Blog | Amazon ECS and Docker volume drivers - Amazon EBS](https://aws.amazon.com/blogs/compute/amazon-ecs-and-docker-volume-drivers-amazon-ebs/)
* [Blog | Graceful shutdowns with ECS](https://aws.amazon.com/blogs/containers/graceful-shutdowns-with-ecs/)
* [Blog | How to create a custom scheduler for Amazon ECS](https://aws.amazon.com/blogs/compute/how-to-create-a-custom-scheduler-for-amazon-ecs/)
* [Video | AWS re:Invent 2019: [NEW LAUNCH] Capacity Providers](https://www.youtube.com/watch?v=v9xuKAdShFw)
* [Project | Amazon ECS CNI Plugins](https://github.com/aws/amazon-ecs-cni-plugins)
* [Samples | Amazon ECS FireLens Examples](https://github.com/aws-samples/amazon-ecs-firelens-examples)
* [Samples | ECS reverse proxy](https://github.com/awslabs/ecs-nginx-reverse-proxy/tree/master/reverse-proxy)
* [Workshops | AWS Workshops for ECS](https://workshops.aws/card/ecs) by [@AWS](http://x.com/aws)



### Kubernetes & Amazon EKS

* [Blog | What are Kubernetes Pods Anyway?](https://www.ianlewis.org/en/what-are-kubernetes-pods-anyway) by [@IanMLewis](https://x.com/IanMLewis)
* [Course | Certified Kubernetes Administrator (CKA) with Practice Tests](https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/)
* [Workshops | AWS Workshops for K8s](https://workshops.aws/categories/Kubernetes) by [@AWS](http://x.com/aws)



