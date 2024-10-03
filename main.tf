module "vpc" {
  source = "./vpc"
}
module "ec2" {
  source = "./ec2"
  pu_sb = module.vpc.pu_sb
  pr_sb = module.vpc.pr_sb
  sg = module.vpc.sg
}
