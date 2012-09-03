#include <iostream>
#include <vector>

#include "Core.h"
#include "Systems.h"
#include "HealthComp.h"
#include "NameComp.h"


int main()
{
    Core core;
    System<HealthComp> hSub(&core);
    System<NameComp> nSub(&core);
    nSub.addComponent(1);
    hSub.addComponent(1);


    //update loop
    //send messages
    nSub.deliverAllMessages();
    hSub.deliverAllMessages();
    nSub.update(0.1);
    hSub.update(0.1);


    return 0;
}



