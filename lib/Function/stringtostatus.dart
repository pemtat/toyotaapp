String stringToStatus(String status) {
  switch (status) {
    case '101':
      return 'pending';
    case '20':
      return 'feedback';
    case '30':
      return "acknowledged";
    case '102':
      return 'confirmed';
    case '25':
      return 'confirmed';
    case '90':
      return 'closed';
    case '50':
      return 'confirmed';
    case '80':
      return 'resolved';
    case '103':
      return 'completed';
    default:
      return 'pending';
  }
}

String stringToStatusQuotation(String status) {
  switch (status) {
    case '1':
      return 'pending';
    case '2':
      return 'approved';
    case '3':
      return "rejected";
    default:
      return 'pending';
  }
}

String stringToStatusQuotationTechMG(String status) {
  switch (status) {
    case '0':
      return 'pending';
    case '1':
      return 'approved';
    case '2':
      return "rejected";
    default:
      return 'pending';
  }
}
